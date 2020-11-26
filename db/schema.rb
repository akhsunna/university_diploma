# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_26_114012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expert_requests", force: :cascade do |t|
    t.string "token"
    t.string "expert_name"
    t.bigint "methodology_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.decimal "expert_weight"
    t.index ["methodology_id"], name: "index_expert_requests_on_methodology_id"
  end

  create_table "methodologies", force: :cascade do |t|
    t.string "name"
  end

  create_table "parameter_methodology_expert_scores", force: :cascade do |t|
    t.bigint "parameter_value_id"
    t.bigint "methodology_id"
    t.bigint "expert_request_id"
    t.integer "status", default: 0
    t.decimal "score"
    t.decimal "expert_weight"
    t.index ["expert_request_id"], name: "index_parameter_methodology_expert_scores_on_expert_request_id"
    t.index ["methodology_id"], name: "index_parameter_methodology_expert_scores_on_methodology_id"
    t.index ["parameter_value_id"], name: "index_parameter_methodology_expert_scores_on_parameter_value_id"
  end

  create_table "parameter_methodology_total_scores", force: :cascade do |t|
    t.bigint "parameter_value_id"
    t.bigint "methodology_id"
    t.decimal "score"
    t.index ["methodology_id"], name: "index_parameter_methodology_total_scores_on_methodology_id"
    t.index ["parameter_value_id"], name: "index_parameter_methodology_total_scores_on_parameter_value_id"
  end

  create_table "parameter_values", force: :cascade do |t|
    t.bigint "parameter_id"
    t.string "value"
    t.decimal "default_weight"
    t.index ["parameter_id"], name: "index_parameter_values_on_parameter_id"
  end

  create_table "parameters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "default_weight"
  end

  create_table "parameters_comparisons", force: :cascade do |t|
    t.bigint "parameter_a_id"
    t.bigint "parameter_b_id"
    t.bigint "project_id"
    t.integer "value", default: 1
    t.boolean "inversed", default: false
    t.integer "status", default: 0
    t.index ["parameter_a_id"], name: "index_parameters_comparisons_on_parameter_a_id"
    t.index ["parameter_b_id"], name: "index_parameters_comparisons_on_parameter_b_id"
    t.index ["project_id"], name: "index_parameters_comparisons_on_project_id"
  end

  create_table "project_methodology_scores", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "methodology_id"
    t.decimal "weighted_sum_score"
    t.index ["methodology_id"], name: "index_project_methodology_scores_on_methodology_id"
    t.index ["project_id"], name: "index_project_methodology_scores_on_project_id"
  end

  create_table "project_parameter_values", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "parameter_id"
    t.bigint "parameter_value_id"
    t.integer "status", default: 0
    t.decimal "weight"
    t.index ["parameter_id"], name: "index_project_parameter_values_on_parameter_id"
    t.index ["parameter_value_id"], name: "index_project_parameter_values_on_parameter_value_id"
    t.index ["project_id"], name: "index_project_parameter_values_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.integer "role"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
