# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_12_010243) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achieve_answers", force: :cascade do |t|
    t.bigint "achieve_question_id", null: false
    t.string "site", null: false
    t.text "respond"
    t.json "original_respond"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achieve_question_id"], name: "index_achieve_answers_on_achieve_question_id"
  end

  create_table "achieve_questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.uuid "achieve_id", null: false
    t.text "question", null: false
    t.text "prompt"
    t.json "origin_params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achieve_id"], name: "index_achieve_questions_on_achieve_id"
    t.index ["user_id"], name: "index_achieve_questions_on_user_id"
  end

  create_table "api_v1_prompts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_v1_prompts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "default_prompt_id", comment: "用户的默认 prompt"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
