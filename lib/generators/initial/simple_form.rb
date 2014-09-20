module Initial
  class SimpleFormGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add
      gem 'simple_form'

      Bundler.with_clean_env do
        run "bundle install"
      end


      str = %q{
Install simple form (choose variant):
1. Basic
2. Bootstrap
3. Zurb
}
      var = ask str, limited: ['1', '2', '3']
      case var
      when '1'
        generate 'simple_form:install'
      when '2'
        generate 'simple_form:install --bootstrap'
      when '3'
        generate 'simple_form:install --foundation'
      end
    end
  end
end
