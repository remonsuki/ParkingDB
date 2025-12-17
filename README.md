# 校園智慧停車場管理系統

## 系統架構

系統採用 **三層架構** 設計，實現了資料的持久化與高可用性：

1.  **呈現層 (Frontend)**：採用 HTML, JavaScript 建立響應式介面。
2.  **應用層 (Backend)**：以 PHP 為核心，並透過 Composer 整合 `mongodb/mongodb` 驅動程式。
3.  **資料層 (Database)**：
    * **MySQL (SQL)**：負責高一致性的交易數據，如使用者帳號、車輛綁定及進出紀錄。
    * **MongoDB (NoSQL)**：負責非結構化數據，利用 **GridFS** 儲存大容量車輛圖片，並儲存彈性的使用者偏好設定。



---

## 資料模型設計 (Data Model)

### 1. SQL (MySQL) - 結構化資料
定義於 `database/sql_ddl.sql`，核心表格如下：

| 表格名稱 | 說明 | 關鍵欄位 |
| :--- | :--- | :--- |
| `user` | 使用者核心資料 | `user_id`, `password`, `violation_count` |
| `vehicle` | 車輛資訊與權限 | `plate_id`, `user_id (FK)` |
| `park_record` | 停車交易紀錄 | `entry_time`, `exit_time`, `total_fee` |

### 2. NoSQL (MongoDB) - 非結構化資料
主要 Collection 與儲存邏輯：

* **`parkingdb`**：儲存車牌與圖片的對應關係。
    * 格式：`{ "plate": "車牌號碼", "photo": ObjectId("GridFS_ID") }`
* **GridFS (`fs.files` & `fs.chunks`)**：真正儲存圖片二進制數據的地方，將大檔案切分為 255KB 的數據塊。

---

## 資料存取流程

### 註冊與圖片儲存 (Write Flow)
1.  **MySQL Transaction**：啟動 ACID 事務，確保 `user` 與 `vehicle` 同時寫入成功。
2.  **GridFS Streaming**：將上傳的圖片轉為二進制流，分塊儲存至 MongoDB。
3.  **Cross-DB Mapping**：將 MongoDB 生成的 `ObjectId` 存回 `parkingdb` 關聯車牌。
4.  **Local Cleanup**：完成後自動 `unlink()` 伺服器上的臨時檔案，實現無塵化管理。



### 會員資料讀取
1.  透過 PHP Session 取得 `user_id` 並查詢 MySQL。
2.  取得車牌後，至 MongoDB 檢索對應的 `photo` (GridFS ID)。
3.  利用 `openDownloadStream` 抓取二進制數據，轉為 **Base64 Data URI** 供前端渲染。

---

## 最小可行性系統 (MVP) 功能清單
- [x] **使用者註冊**：整合 MySQL 交易與 MongoDB GridFS 儲存。
- [x] **進出場模擬**：自動判斷進出場狀態並更新紀錄。
- [x] **會員中心**：動態展示個人資料與儲存在 NoSQL 的圖片。
- [x] **違規偵測**：初步實現超時停車監控邏輯。

---

## 環境安裝需求

1.  **PHP 8.1+**
2.  **MySQL 8.0+**
3.  **MongoDB 6.0+**
4.  **PHP MongoDB Driver**:
    ```bash
    composer require mongodb/mongodb
    ```
