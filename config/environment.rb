# Load the rails application
DEFAULT_PAPERCLIP_OPTIONS = {}

DEVISE_MAILER_FROM       = "ipes4579@gmail.com"
LIVE_PERSONS_EMAIL       = 'ipes4579@gmail.com'

FACEBOOK_APP_ID          = "213491825331116"
FACEBOOK_APP_SECRET      = "3bc4798fec78dc85235d543aa96e5f98"
FACEBOOK_APP_PERMISSIONS = "email,offline_access,publish_stream"

DEFAULT_FB_SHARE_IMAGE   = "http://chakkomi.heroku.com/images/missing.png"
DEFAULT_FB_POST_NAME     = "Chakkomi"

DEFAULT_PAGE_TITLE       = "Chakkomi"
DEFAULT_PAGE_DESCRIPTION = "Description for Chakkomi"

TWITTER_SECRET_KEY       = "WqPTsJJklVOTjBkSes1Eovu4muDnLjNG8p3QMbvQq3Q"
TWITTER_CONSUMER_KEY     = "MihJNbixbwbJoMZTsu2w"

DEFAULT_SHARE_URL        = "http://chakkomi.heroku.com/"

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Chakkomi::Application.initialize!
