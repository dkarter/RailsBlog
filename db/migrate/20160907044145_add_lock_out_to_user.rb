class AddLockOutToUser < ActiveRecord::Migration
  def up
    execute <<-SQL
    alter table users
      add column locked_out_timestamp timestamp,
      add column failed_login_attempts integer not null default 0;
    SQL
  end

  def down
    execute <<-SQL
    alter table users
      drop column locked_out_timestamp,
      drop column failed_login_attempts;
    SQL
  end
end
