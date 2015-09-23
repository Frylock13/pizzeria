Ckeditor.setup do |config|
  require 'ckeditor/orm/active_record'
  config.assets_languages = ['en', 'ru']
  config.assets_plugins = ['a11yhelp', 'autocorrect', 'autoembed', 'autogrow', 'autolink',
                           'clipboard', 'codemirror', 'codesnippet', 'colordialog', 'dialog',
                           'div', 'embed', 'embedbase', 'find', 'image', 'leaflet', 'lineutils',
                           'link', 'liststyle', 'magicline', 'notification',
                           'notificationaggregator', 'pastefromword', 'quicktable',
                           'showblocks', 'table', 'tabletools', 'textselection', 'widget',
                           'widgetbootstrap', 'widgetcommon', 'widgettemplatemenu', 'wordcount']
  config.image_file_types = ['jpg', 'jpeg', 'png', 'gif', 'tiff']
  # config.asset_path = '/assets/ckeditor/'
  # config.attachment_file_model { Ckeditor::AttachmentFile }
  # config.attachment_file_types = ["doc", "docx", "xls", "odt", "ods", "pdf", "rar", "zip", "tar", "swf"]
  # config.authorize_with :cancan
  # config.default_per_page = 24
  # config.picture_model { Ckeditor::Picture }
end
