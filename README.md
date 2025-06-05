# 薬の飲み忘れ防止アプリ
# Medication Reminder

このプロジェクトは、薬の飲み忘れを防止し、服薬管理をサポートするアプリケーションです。

---

## データベース設計



### 1. アプリケーションの主要なデータ（エンティティ）


* **`users` (ユーザー)**
    * アプリを使う人の情報です。薬の登録や服用記録の管理を行う主体となります。
* **`medications` (薬)**
    * ユーザーが登録する個々の薬の情報です。薬の名前、服用量、服用タイミング、服用期間などを管理します。
* **`doses` (服用記録)**
    * 特定の薬を、特定の日時、特定のタイミングで「服用したか」という記録です。服用したかどうか、実際に服用した時刻などを記録します。

---

### 2. 各テーブルの詳細

次に、それぞれのテーブルがどんな項目（**カラム**）を持っているのか、そのデータの種類（**型**）、そして簡単な説明を見ていきましょう。

#### `users` テーブル

| カラム名         | 型         | 説明                                       |
| :--------------- | :--------- | :----------------------------------------- |
| `id`                     | `UUID`     | ユーザーを識別するID (**主キー**)          |
| `email`                  | `string`   | ログインに使用するメールアドレス           |
| `encrypted_password`     | `string`   | 暗号化されたパスワード                     |
| `time_zone`              | `string`   | ユーザーの住む地域のタイムゾーン (例: 'Tokyo') |
| `default_morning_time`   | `time`     | ユーザーが設定する標準的な朝の服用時間     |
| `default_noon_time`      | `time`     | ユーザーが設定する標準的な昼の服用時間     |
| `default_evening_time`   | `time`     | ユーザーが設定する標準的な夕の服用時間     |
| `default_bedtime`        | `time`     | ユーザーが設定する標準的な就寝前の服用時間 |
| `created_at`             | `datetime` | レコードが作成された日時                   |
| `updated_at`             | `datetime` | レコードが最後に更新された日時             |

#### `medications` テーブル

| カラム名         | 型         | 説明                                       |
| :--------------- | :--------- | :----------------------------------------- |
| `id`             | `UUID`     | 薬を識別するID (**主キー**)                |
| `user_id`        | `UUID`     | この薬を登録したユーザーのID (**外部キー**) |
| `name`           | `string`   | 薬の名前 (例: '頭痛薬', '高血圧の薬')      |
| `dosage`         | `string`   | 1回あたりの服用量 (例: '1錠', '5ml')       |
| `type`           | `string`   | 薬の形状や種類 (例: '錠剤', 'カプセル', 'シロップ') |
| `start_date`     | `date`     | 服用を開始した日付                         |
| `end_date`       | `date`     | 服用を終了する日付 (任意)                  |
| `take_morning`   | `boolean`  | 朝に服用するかどうか (true/false)          |
| `take_noon`      | `boolean`  | 昼に服用するかどうか (true/false)          |
| `take_evening`   | `boolean`  | 夕に服用するかどうか (true/false)          |
| `take_bedtime`   | `boolean`  | 就寝前に服用するかどうか (true/false)      |
| `memo`           | `text`     | 薬に関するメモや特記事項 (任意)            |
| `created_at`     | `datetime` | レコードが作成された日時                   |
| `updated_at`     | `datetime` | レコードが最後に更新された日時             |

#### `doses` テーブル

| カラム名         | 型         | 説明                                       |
| :--------------- | :--------- | :----------------------------------------- |
| `id`             | `UUID`     | 服用記録を識別するID (**主キー**)          |
| `medication_id`  | `UUID`     | この服用記録がどの薬に関するものか (**外部キー**) |
| `user_id`        | `UUID`     | この服用記録を行ったユーザーのID (**外部キー**) |
| `scheduled_time` | `datetime` | 本来服用する予定だった日時                 |
| `taken_at`       | `datetime` | 実際に薬を服用した日時 (任意)              |
| `is_taken`       | `boolean`  | 薬が服用されたかどうか (true/false)        |
| `dose_type`      | `string`   | 服用タイミングの種類 (例: 'morning', 'noon') |
| `created_at`     | `datetime` | レコードが作成された日時                   |
| `updated_at`     | `datetime` | レコードが最後に更新された日時             |

---

### 3. テーブル間の関連付け (アソシエーション)

* **`User` と `Medication` の関連**
    * **一人のユーザー (`User`) は、複数の薬 (`Medication`) を登録できます。**
        * (Railsでの記述例: `User` モデルに `has_many :medications`)
    * **一つの薬 (`Medication`) は、必ず一人のユーザーに属します。**
        * (Railsでの記述例: `Medication` モデルに `belongs_to :user`)

* **`Medication` と `Dose` の関連**
    * **一つの薬 (`Medication`) には、複数の服用記録 (`Dose`) が紐づきます。**
        * (Railsでの記述例: `Medication` モデルに `has_many :doses`)
        * 薬が削除された際に、その薬に関連する服用記録も同時に削除されるよう、`dependent: :destroy`を設定することを推奨します。
    * **一つの服用記録 (`Dose`) は、必ず一つの薬に紐づきます。**
        * (Railsでの記述例: `Dose` モデルに `belongs_to :medication`)

* **`User` と `Dose` の関連**
    * **一人のユーザー (`User`) は、複数の服用記録 (`Dose`) を持っています。**
        * (Railsでの記述例: `User` モデルに `has_many :doses`)
    * **一つの服用記録 (`Dose`) は、必ず一人のユーザーによって記録されます。**
        * (Railsでの記述例: `Dose` モデルに `belongs_to :user`)

パスワード再設定
http://localhost:3000/letter_opener
