# WatchR - Mobile OSINT Tool


[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/lazyp4nd4/WatchR">
    <img src="assets/WatchRlogo.jpg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">WatchR</h3>

  <p align="center">
    A mobile OSINT tool for generating profiles.
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#install-android-apk-directly">Install Anroid apk Directly</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

![Product Name Screen Shot](https://github.com/lazyp4nd4/WatchR/blob/main/Screenshots/About%20Project.jpeg?raw=true)


WatchR is a mobile OSINT tool that can be used to track phone numbers, IP addresses and generate profiles using email-ids. An OSINT (Open Source INTelligence) tool refers to a computer application that helps us retrieve more information about a person that has been made public by the user by tracing the footsteps of some information provided to us about the same user.

WatchR makes use of 3 APIs to perform its tasks:
* Censys API: to trace the IP address and locate it on Google Maps.
* NumVerify API: to track the details linked to a phone number, including service provider, location of circle, and the line type.
* Hunter API: to generate profiles using email id of a person. This email id should belong to a particular domain for the API to work.

Since, most of the OSINT tools available on GitHub require a CLI setup which may even involve downloading and installing numerous packages, we decided to create an easy-to-use mobile application to serve the same purpose. The lack of free and open source mobile OSINT tools in the market is what makes WatchR unique.

### Built With

* [Flutter (frontend)](https://flutter.dev/)
* [Flask (backend)](https://flask.palletsprojects.com/en/2.0.x/)



<!-- GETTING STARTED -->
## Getting Started

To install the entire Flutter project on your local system and run it on an IDE, follow the following steps:

### Prerequisites

* Flutter ([Install Flutter](https://flutter.dev/docs/get-started/install))
Run the following command on Command Prompt to make sure Flutter is ready on your local system:
  ```sh
  flutter doctor -v
  ```
* Flask  ([Install Flask](https://phoenixnap.com/kb/install-flask))
  Run 'pip freeze' on command prompt and try to find Flask in the list to check if the system has sucessfully installed Flask or not.
  ```sh
  pip freeze
  ```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/lazyp4nd4/WatchR.git
   ```
3. Run the Flutter project
   ```sh
   flutter run WatchR
   ```

### Install Android apk Directly

Directly install the apk of WatchR from [this link](https://github.com/lazyp4nd4/WatchR/blob/main/Apk/app-release.apk)



<!-- USAGE EXAMPLES -->
## Usage

Upon opening the app, a user would be directed to the registration/login screen. If the user already has an account, they can directly sign-in using their credentials, else, they can create an account using their email-id or by signing in with Google.

![Login Page](https://github.com/lazyp4nd4/WatchR/blob/main/Screenshots/Login.png?raw=true)

![Register Page](https://github.com/lazyp4nd4/WatchR/blob/main/Screenshots/Register.png?raw=true)

After successfully signing into the app, the user will be displayed three options:
* Locate IP Address
* Locate Phone Number
* Generate Profile

![Home Page](https://github.com/lazyp4nd4/WatchR/blob/main/Screenshots/home.png?raw=true)


The user can select any of these options and use the respective APIs to get results. Following are some screenshots of the results generated:

![Locate IP Address](https://github.com/lazyp4nd4/WatchR/blob/main/Screenshots/map.png?raw=true)

![Profiles Generated](https://github.com/lazyp4nd4/WatchR/blob/main/Screenshots/SearchResults.png?raw=true)

The user can also view their previous searches saved in the database:
![Previously Searched Relsults](https://github.com/lazyp4nd4/WatchR/blob/main/Screenshots/Previous.png?raw=true)
<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/lazyp4nd4/WatchR/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- CONTACT -->
## Contact

Shourya - [@Shourya](https://www.linkedin.com/in/shourya-3b43a41a5/) - shouryak95@gmail.com

Project Link: [https://github.com/lazyp4nd4/WatchR](https://github.com/lazyp4nd4/WatchR)







<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png
