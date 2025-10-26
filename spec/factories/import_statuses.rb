FactoryBot.define do
  factory :import_status do
    user { nil }
    filename { "MyString" }
    status { "MyString" }
    total_rows { 1 }
    processed_rows { 1 }
    success_count { 1 }
    error_count { 1 }
    error_messages { "MyText" }
    started_at { "2025-10-25 15:04:04" }
    completed_at { "2025-10-25 15:04:04" }
  end
end
