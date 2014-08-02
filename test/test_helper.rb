Dir.chdir File.expand_path("../../", __FILE__)
$LOAD_PATH.unshift ".", "lib", "test"

require 'set'
require 'i18n'

I18n.config.enforce_available_locales = true


require "minitest/autorun"
