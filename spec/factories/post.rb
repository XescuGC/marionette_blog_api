FactoryGirl.define do
  factory :post do
    title         'title'
    tags          { [build(:tag)] }
    created_at    { Time.now  }
    updated_at    { Time.now  }
    body          'Body Post'
    preface       'Preface Post'
  end
end
