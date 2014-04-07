# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140306085748) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "targetable_id"
    t.string   "targetable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "activities", ["targetable_id", "targetable_type"], :name => "index_activities_on_targetable_id_and_targetable_type"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "auditors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "audit_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "audits", :force => true do |t|
    t.string   "department_name"
    t.string   "auditee_name"
    t.string   "auditee_email"
    t.string   "auditor_name"
    t.string   "auditor_email"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "user_id"
    t.string   "audit_type"
    t.string   "location"
    t.string   "secondry_auditor_name"
    t.string   "secondry_auditor_email"
  end

  add_index "audits", ["audit_type"], :name => "index_audits_on_audit_type"
  add_index "audits", ["user_id"], :name => "index_audits_on_user_id"

  create_table "dashboards", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "documents", :force => true do |t|
    t.integer  "finding_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "documents", ["finding_id"], :name => "index_documents_on_finding_id"

  create_table "finding_statuses", :force => true do |t|
    t.string   "status_name"
    t.string   "string"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "finding_types", :force => true do |t|
    t.string   "category_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "findings", :force => true do |t|
    t.text     "description"
    t.string   "category"
    t.string   "risk_rating"
    t.date     "date_created"
    t.text     "corrective_action"
    t.text     "preventive_action"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "audit_id"
    t.string   "status_id"
    t.integer  "document_id"
    t.string   "iso_clause"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "closure_date"
  end

  add_index "findings", ["audit_id"], :name => "index_findings_on_audit_id"
  add_index "findings", ["iso_clause"], :name => "index_findings_on_iso_clause"
  add_index "findings", ["status_id"], :name => "index_findings_on_status_id"

  create_table "reports", :force => true do |t|
    t.string   "report_name"
    t.string   "report_tag"
    t.string   "report_status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "risks", :force => true do |t|
    t.string   "risk_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "profile_name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "mobile_number"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
