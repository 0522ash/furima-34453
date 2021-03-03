# テーブル設計

## users table

| Column             | Types  | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null :false               |
| email              | string | null :false, unique: true |
| encrypted_password | string | null :false               |
| surname            | string | null :false               |
| firstname          | string | null :false               |
| kana_surname       | string | null :false               |
| kana_firstname     | string | null :false               |
| birthday           | date   | null :false               |

### Association

has_many :items
has_many :comments
has_many :customer_infos

## items table

| Column              | Types      | Options           |
| ------------------- | ---------- | ----------------- |
| title               | string     | null : false      |
| category_id         | integer    | null : false      |
| detail              | text       | null : false      |
| condition_id        | integer    | null : false      |
| shipping_charge_id | integer    | null : false      |
| ship_from_id        | integer    | null : false      |
| guideline_id        | integer    | null : false      |
| price               | integer    | null : false      |
| user                | references | foreign_key: true |

### Association

belongs_to :user
has_many :comments
has_one :customer_info

## comments table

| Column | Types      | Options           |
| ------ | ---------- | ----------------- |
| text   | text       | null : false      |
| user   | references | foreign_key: true |
| items  | references | foreign_key: true |

### Association

belongs_to :user
belongs_to :item


## customer_info table

| Column | Types      | Options           |
| ------ | ---------- | ----------------- |
| item   | references | foreign_key :true |
| user   | references | foreign_key :true |


### Association

has_one :shipping_info
belongs_to :item
belongs_to :user


## shipping_info table

| Column        | Types      | Options           |
| ------------- | ---------- | ----------------- |
| postal_code   | string     | null :false       |
| ship_from_id  | integer    | null :false       |
| city          | string     | null :false       |
| address       | string     | null :false       |
| building_name | string     |                   |
| phone_number  | string     | null :false       |
| customer_info | references | foreign_key: true |

### Association

belongs_to :customer_info
