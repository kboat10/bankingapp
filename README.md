# 🏦 Banking App

A Flutter mobile banking application that I built as a student project to learn mobile app development. This was my first major Flutter project and I learned so much along the way!

## 📱 App Overview

This banking app includes all the essential features you'd expect from a modern banking application:

### 🔐 **Authentication**
- User registration and login system
- Secure password validation
- User-specific data management

### 🏠 **Main Features**
- **Dashboard**: Overview of account balances and recent transactions
- **Transfer Money**: Send money to other accounts
- **Pay Bills**: Manage utility payments (electricity, water, internet)
- **My Accounts**: View all your accounts (savings, checking, investment)
- **My Cards**: Manage credit and debit cards
- **Transaction History**: Complete log of all financial activities

### 🛠️ **Support & Services**
- **Help Center**: FAQs and support resources
- **Settings**: App preferences and security settings
- **Contact Us**: Direct communication with support
- **Cheque Services**: Deposit and manage cheques
- **More Options**: Additional banking services

## 🚀 How to Run the App

### Prerequisites
- Flutter SDK (I used Flutter 3.x)
- Dart programming language
- Android Studio / VS Code
- Android emulator or physical device

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/kboat10/bankingapp.git
   cd bankingapp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Running on Different Platforms
- **Android**: `flutter run` (with emulator or device connected)
- **iOS**: `flutter run` (requires macOS and Xcode)
- **Web**: `flutter run -d chrome`
- **macOS**: `flutter run -d macos`

## 🎯 Key Challenges & What I Learned

### 1. **State Management with Provider** 🤯
**Challenge**: I had no idea how to manage app state when I started. Everything was so confusing!

**What I Learned**: 
- Provider is actually pretty straightforward once you understand the concept
- `ChangeNotifier` is like a data container that can notify widgets when data changes
- Using `Consumer` and `Provider.of` to access data from anywhere in the app
- How to structure providers for different features (UserProvider, AccountsProvider)

### 2. **Navigation and Routing** 🧭
**Challenge**: I kept getting lost with navigation! Push, pop, pushReplacement - what does it all mean?

**What I Learned**:
- Named routes are much cleaner than manual navigation
- `Navigator.pushNamed()` vs `Navigator.pushReplacementNamed()` - the difference matters!
- How to pass data between screens
- Bottom navigation bar implementation

### 3. **Form Validation** ✅
**Challenge**: Making sure users enter correct data was harder than I thought!

**What I Learned**:
- Regular expressions (regex) for email and password validation
- Real-time validation using `TextEditingController`
- Password matching validation (this was tricky!)
- Form field styling and error messages

### 4. **User-Specific Data** 👤
**Challenge**: Making sure each user only sees their own data was a big challenge!

**What I Learned**:
- How to structure data to be user-specific
- Clearing data on logout
- Managing user sessions
- Data persistence concepts

### 5. **UI/UX Design** 🎨
**Challenge**: Making the app look professional and user-friendly

**What I Learned**:
- Material Design principles
- Card layouts and elevation
- Color schemes and theming
- Responsive design basics
- Icon usage and consistency

### 6. **Git and Version Control** 📝
**Challenge**: Learning Git was overwhelming at first!

**What I Learned**:
- Basic Git commands (add, commit, push)
- Creating and managing GitHub repositories
- Writing meaningful commit messages
- Understanding the workflow

## 🛠️ Technologies Used

- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language
- **Provider**: State management
- **Material Design**: UI components and design system

## 📁 Project Structure

```
lib/
├── main.dart              # App entry point and routing
├── models/                # Data models
│   ├── user_model.dart
│   ├── account_model.dart
│   └── transaction_model.dart
├── providers/             # State management
│   ├── user_provider.dart
│   └── accounts_provider.dart
└── screens/               # App screens
    ├── login_screen.dart
    ├── signup_screen.dart
    ├── dashboard_screen.dart
    ├── transfer_screen.dart
    ├── bills_screen.dart
    ├── accounts_screen.dart
    ├── cards_screen.dart
    ├── more_screen.dart
    ├── help_screen.dart
    ├── settings_screen.dart
    ├── contact_us_screen.dart
    ├── cheque_services_screen.dart
    └── history_screen.dart
```

## 🎓 What This Project Taught Me

This project was a huge learning experience! I went from knowing almost nothing about Flutter to building a fully functional banking app. Here are the main takeaways:

- **Mobile Development**: Understanding the mobile app development lifecycle
- **State Management**: How to manage app data effectively
- **User Experience**: Creating intuitive and user-friendly interfaces
- **Problem Solving**: Breaking down complex features into manageable pieces
- **Version Control**: Professional development practices
- **Documentation**: The importance of good documentation

## 🔮 Future Improvements

If I had more time, I would love to add:
- Real backend integration
- Push notifications
- Biometric authentication
- Dark mode theme
- More advanced animations
- Unit testing

## 👨‍💻 About the Developer

**Designed by Nana Kwaku Afriyie Ampadu-Boateng**
- Version 1.0
- This is my first major Flutter project
- I'm still learning and improving every day!

## 📞 Support

If you have any questions or want to connect:
- GitHub: [kboat10](https://github.com/kboat10)
- Feel free to open an issue or contribute to the project!

---

*This project was created as part of my Flutter learning journey. I'm proud of how far I've come and excited to continue learning! 🚀*

