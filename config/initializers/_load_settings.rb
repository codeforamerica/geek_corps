# Load application settings from config/settings.yml
settings_yml = HashWithIndifferentAccess.new(YAML.load_file(Rails.root.join('config', 'settings.yml')))

merged_settings = settings_yml['common']
merged_settings.deep_merge!(settings_yml[Rails.env]) if settings_yml.has_key?(Rails.env)

SETTINGS = merged_settings

S3_KEY = ENV['S3_KEY']
S3_SECRET = ENV['S3_SECRET']
