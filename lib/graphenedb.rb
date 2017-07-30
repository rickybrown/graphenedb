require "net/https"
require "uri"
require "json"

ENDPOINT = "https://api.graphenedb.com/v1"

# Where http calls are made
require_relative "requests"
require_relative 'graphenedb/configuration'

module Graphenedb
  # graphenedb configuration
  class << self
    attr_accessor :configuration
  end
  def self.configuration
    @configuration ||= Configuration.new
  end
  def self.reset
    @configuration = Configuration.new
  end
  def self.configure
    yield(configuration)
  end

  # --------------------------------------

  # List all databases
  def self.databases
    get('databases')
  end
  # Get one database
  def self.database(id)
    get("databases/#{id}")
  end
  # Empty a database
  def self.empty_database(id)
    put("databases/#{id}/empty")
  end
  # Export a database
  def self.export_database(id)
    put("databases/#{id}/export")
  end
  # restart database
  def self.restart_database(id)
    put("databases/#{id}/restart")
  end
  # create database
  def self.create_database(val, opts = {})
    if val.is_a?(String)
      name = val
      val  = {}
    end
    body = {
      name:       val[:name]    || name,
      version:    val[:version] || Graphenedb.configuration.version,
      awsRegion:  val[:region]  || Graphenedb.configuration.region,
      plan:       val[:plan]    || Graphenedb.configuration.plan
    }
    post("databases", body)
  end
  # clone database
  def self.clone_database(val, name = nil, opts = {})
    if val.is_a?(String)
      id  = val
      val = {}
    else
      id = val[:id]
    end
    body = {
      name:       val[:name]    || name,
      version:    val[:version] || Graphenedb.configuration.version,
      awsRegion:  val[:region]  || Graphenedb.configuration.region,
      plan:       val[:plan]    || Graphenedb.configuration.plan
    }
    post("databases/#{id}/clone", body)
  end
  # delete database
  def self.delete_database(id)
    delete("databases/#{id}")
  end

  # -------------------------------------------------

  # Get database users
  def self.users(id)
    get("databases/#{id}/users")
  end
  # Get database user
  def self.user(did, uid)
    get("databases/#{did}/users/#{uid}")
  end
  # create database user
  def self.create_user(val, desc = nil, opts = {})
    if val.is_a?(String)
      id  = val
      val = {}
    else
      id = opts[:database]
    end
    body = {
      description: opts[:description] || desc,
      expireAt:    opts[:expire_at]   || 'never'
    }
    post("databases/#{id}/users", body)
  end
  # Get database user
  def self.delete_user(did, uid)
    delete("databases/#{did}/users/#{uid}")
  end

  # ---------------------------------------------

  # List database backups
  def self.backups(id)
    get("databases/#{id}/backups")
  end
  # Get one database backup
  def self.backup(did, bid)
    get("databases/#{did}/backups/#{bid}")
  end
  # Get database backup url
  def self.backup_url(did, bid)
    get("databases/#{did}/backups/#{bid}/package")
  end
  # Get backup schedules
  def self.all_backup_schedules(id)
    get("databases/#{id}/backups/schedule")
  end
  # Get backup schedules
  def self.backup_schedules(opts = {})
    put("databases/#{opts[:id]}/backups/schedule", opts)
  end
  # Manual backup of database
  def self.snapshot(id)
    put("databases/#{id}/snapshot")
  end
  # Restore backup to database
  def self.restore_backup(did, bid)
    put("databases/#{did}/backups/#{bid}/restore")
  end
  # Import backup to database
  def self.import(val, url = nil, opts = {})
    if val.is_a?(String)
      id  = val
      val = {}
    else
      id = val[:id]
    end
    body = { url: val[:url] || url }
    put("databases/#{id}/snapshot", body)
  end

  # ------------------------------------------------

  # List available database versions
  def self.versions
    get("databases/versions")
  end
  # Get the status of an async operation
  def self.operation(id)
    get("operations/#{id}")
  end
end
