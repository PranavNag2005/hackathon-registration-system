# 🏁 Individual Hackathon Portal – Event Flow, Submissions & Admin Analytics

This project is a **backend-powered portal** for managing single-user hackathons with time-based automation, analytics-driven admin dashboards, and strict workflow control for fairness and clarity. Designed for **one event at a time**, it streamlines registration, project submission, rating, and result declaration with minimal manual intervention.

---

## 🚀 Tech Stack

- **Java Servlet + JSP** – Backend logic and dynamic page rendering  
- **MySQL** – Relational database for participants, projects, events  
- **HTML, CSS, JavaScript** – Interactive frontend components  
- **DAO Pattern** – Clean data abstraction  
- *(Spring Boot migration planned for future releases)*

---

## 🌟 Features Overview

### 👤 User Workflow

- 🔒 **Registration within Deadline Only**  
  Users can register only before the deadline; portal locks post expiry.

- 📝 **Project Submission with Field Locking**  
  After registration, users access:
  - Project Details Submission Field
  - GitHub project link field  
  - Word document upload field  
  - Final submit button  

  Once submitted:
  - All fields become read-only  
  - `Edit Project` stays enabled for tweaks
  - User can view the data after their submission

- ⏲️ **Automated Result Flow**  
  - After hackathon ends, results are published **6 hours later**  
  - No manual refresh needed

---

### 🧑‍💼 Admin Panel & Analytics
- **Super Admin**
- Super Admin can Update the Events and delete the Event
- Super Admin can create the Event
  
- 📊 **Dashboard with Pie Charts**  
  - Live charts for:
    - Registered vs. non-registered users  
    - Project submissions  
    - Rating distribution  

- 🧮 **User Management**  
  - View full participant list  
  - Filter users based on status or rating  
  - Download full list to `.pdf`  
    *(Filtered results not downloadable — ensures unbiased data extraction)*

- 🌟 **Rating & Results Engine**  
  - Admin assigns ratings post-hackathon  
  - Results page highlights **Top Projects** based on scores

- 📧 **Email Notifications (Time-Based)**  
  - Triggers for registration confirmation  
  - Submission deadline reminders  
  - Result announcement alerts

- ⚙️ **Event Control**  
  - Modify event settings live (title, deadline, duration)  
  - Admin has full control over transitions and announcements

---

## 🛠 Platform Behavior

- 🧍 **Single-User Mode**  
  No teams or grouped submissions — built for individual competitors

- 🕒 **One Event Handling**  
  Supports one event at a time for high system stability  
  Results auto-declared after event closes + 2 hours

---


