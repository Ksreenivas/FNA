class Document < ActiveRecord::Base
 attr_accessible :attachment, :finding_id

 has_attached_file :attachment

 belongs_to :finding 
# accepts_nested_attributes_for :findings
include Rails.application.routes.url_helpers

  #def to_jq_upload
  #  {
  ##    "name" => read_attribute(:attachment_file_name),
   #   "size" => read_attribute(:attachment_file_size),
   #   "url" => upload.url(:original),
   #   "delete_url" => upload_path(self),
   #   "delete_type" => "DELETE" 
   # }
  #end
 #mount_uploader :attachment, AttachmentUploader
end
