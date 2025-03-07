# frozen_string_literal: true

# typed: strict

module Libcodeowners
  module FilePathFinder
    module_function

    extend T::Sig
    extend T::Helpers

    # Returns a string version of the relative path to a Rails constant,
    # or nil if it can't find anything
    sig { params(klass: T.nilable(T.any(T::Class[T.anything], Module))).returns(T.nilable(String)) }
    def path_from_klass(klass)
      if klass
        path = Object.const_source_location(klass.to_s)&.first
        (path && Pathname.new(path).relative_path_from(Pathname.pwd).to_s) || nil
      else
        nil
      end
    rescue NameError
      nil
    end
  end
end
