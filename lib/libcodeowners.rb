# frozen_string_literal: true

require_relative 'libcodeowners/version'
require_relative 'libcodeowners/libcodeowners'
require 'code_teams'
require 'sorbet-runtime'

module Libcodeowners
  module_function

  extend T::Sig
  extend T::Helpers
  requires_ancestor { Kernel }

  sig { params(file_path: String).returns(T.nilable(CodeTeams::Team)) }
  def for_file(file_path)
    @for_file ||= T.let(@for_file, T.nilable(T::Hash[String, T.nilable(CodeTeams::Team)]))
    @for_file ||= {}

    return nil if file_path.start_with?('./')
    return @for_file[file_path] if @for_file.key?(file_path)

    result = T.let(RustCodeOwners.for_file(file_path), T.nilable(T::Hash[Symbol, String]))
    return if result.nil?

    if result[:team_name].nil?
      @for_file[file_path] = nil
    else
      @for_file[file_path] = T.let(find_team!(result[:team_name]), T.nilable(CodeTeams::Team))
    end
  end

  sig { void }
  def self.bust_caches!
    @for_file = nil
  end

  sig { params(team_name: String).returns(CodeTeams::Team) }
  def find_team!(team_name)
    CodeTeams.find(team_name) ||
      raise(StandardError, "Could not find team with name: `#{team_name}`. Make sure the team is one of `#{CodeTeams.all.map(&:name).sort}`")
  end
end
