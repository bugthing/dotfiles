desc 'rolls back migrations in current branch not present in other'
task :rollback_branch_migrations, [:other_branch] do |t, args|
  load "#{Dir.pwd}/Rakefile"

  branch_migrations = BranchMigrations.new(args.other_branch)

  puts ['Rollback the following migrations', branch_migrations, 'y,n? ']
  next if %w[no n NO N].include?(STDIN.gets.chomp)

  migrate_task = Rake::Task['db:migrate:down']

  branch_migrations.each_version do |version|
    ENV['VERSION'] = version
    migrate_task.execute
  end

  puts 'Will probably need to discard changes to db/schema.rb'
end

class BranchMigrations
  def initialize other_branch
    @other_branch = other_branch
  end

  attr_reader :other_branch

  def each_version
    filenames.each do |filename|
      yield filename.split('_')[0]
    end
  end

  def filenames
    list.map { |migration_path| migration_path.match(%r{/(\d+.*)\z})[1] }
  end

  def list
    @list ||= begin
      list = %x{git diff #{other_branch} --name-only --diff-filter=A db/migrate/}
      list.split.reverse
    end
  end

  def to_ary; filenames end
end
