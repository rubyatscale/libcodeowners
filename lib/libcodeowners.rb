# frozen_string_literal: true

# typed: strict

require 'code_teams'
require 'packs-specification'
require 'sorbet-runtime'
require_relative 'libcodeowners/file_path_team_cache'
require_relative 'libcodeowners/team_finder'
require_relative 'libcodeowners/version'
require_relative 'libcodeowners/libcodeowners'
require_relative 'libcodeowners/file_path_finder'
module Libcodeowners
  module_function

  extend T::Sig
  extend T::Helpers
  requires_ancestor { Kernel }

  sig { params(file_path: String).returns(T.nilable(CodeTeams::Team)) }
  def for_file(file_path)
    TeamFinder.for_file(file_path)
  end

  sig { params(klass: T.nilable(T.any(T::Class[T.anything], Module))).returns(T.nilable(::CodeTeams::Team)) }
  def for_class(klass)
    TeamFinder.for_class(klass)
  end

  sig { params(package: Packs::Pack).returns(T.nilable(::CodeTeams::Team)) }
  def for_package(package)
    TeamFinder.for_package(package)
  end

  # Given a backtrace from either `Exception#backtrace` or `caller`, find the
  # first line that corresponds to a file with assigned ownership
  sig { params(backtrace: T.nilable(T::Array[String]), excluded_teams: T::Array[::CodeTeams::Team]).returns(T.nilable(::CodeTeams::Team)) }
  def for_backtrace(backtrace, excluded_teams: [])
    TeamFinder.for_backtrace(backtrace, excluded_teams: excluded_teams)
  end

  # Given a backtrace from either `Exception#backtrace` or `caller`, find the
  # first owned file in it, useful for figuring out which file is being blamed.
  sig { params(backtrace: T.nilable(T::Array[String]), excluded_teams: T::Array[::CodeTeams::Team]).returns(T.nilable([::CodeTeams::Team, String])) }
  def first_owned_file_for_backtrace(backtrace, excluded_teams: [])
    TeamFinder.first_owned_file_for_backtrace(backtrace, excluded_teams: excluded_teams)
  end

  sig { void }
  def bust_cache!
    FilePathTeamCache.bust_cache!
  end
end
