# Daily Budget Tracker


## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Users can track their daily spendings by using this app. By creating an interactive and visual way to see where our money goes we hope to intrigue users to become more aware of their spendings and budgeting skills. This app will allow users to sign up and log in to update their purchases. Users can upload pictures and/or descriptions of their purchases along with their costs, and the app calculates their total spending over the course of a day.  

### App Evaluation

- **Category:** Personal Finance
- **Mobile:** This app is primarily for mobile since it uses the camera. However, since you can have a description in place of a picture, it would also be functional on a computer.
- **Story:** Tracks one's spending on a daily basis by calculating the total of the prices they inputted. Also tracks weekly/monthly spending.
- **Market:** Anyone who spends money can use this app, but it mainly targets those with jobs as they would have more responsibilities and thus more incentive to keep track of their spending.
- **Habit:** This app could be used every time a user makes a purchase. However, a user may also use this app only to track specific types of purchases, such as those relating to food.
- **Scope:** We would first enable users to upload purchases—a purchase being a price with a picture and/or description—and then calculate their total spending over the course of the day, which would reset when a new day begins at 12 AM. Then, we would add the ability to log in and sign up. Lastly, we'd implement weekly/monthly spending as a separate tab. An optional feature could be the ability to set spending goals.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can upload purchases, where a purchase consists of a price along with a picture and/or description
* App calculates total spending over the course of a day
* User can sign up and log in
* App calculates weekly/monthly spending

**Optional Nice-to-have Stories**

* User can set spending goals for the week/month

### 2. Screen Archetypes

* Login
* Register:
   * Users can either log in to a existing account or sign up for a new one.
* Main/home feed screen
    * Users are able to see the total amount of their spending that day, and all the purchases they uploaded that day.
* Upload screen 
    * Users upload either a live picture or a picture from their photo library and a description of their purchase along with the total spent. They then add it to the main feed by pressing the 'Add' button.
* Weekly/monthly spendings screen
    * Users are able to pick the week/month for which they want to see their spendings.
* Total weekly/monthly spendings detail screen
    * Users are able to view the total amount of money spent within a specific week/month.


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Main/home feed (daily spending)
* Total weekly/monthly spendings

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is available
* Main feed -> Upload screen
* Weekly/monthly spendings -> Weekly/monthly spendings detail screen

## Wireframes

<img src="https://i.imgur.com/yjLU1k8.jpg" width=600>

<img src="https://i.imgur.com/VBKwLsc.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]


![ezgif-1-114406bf90](https://user-images.githubusercontent.com/110207696/235591509-23866dca-76ff-4972-8b9c-927cfb41359b.gif)


![ezgif-1-e0cf9d42db](https://user-images.githubusercontent.com/110207696/235591901-60422fc0-1b7d-47f5-8570-1c4b21f8a825.gif)


![ezgif-1-9b60febacd](https://user-images.githubusercontent.com/110207696/235591616-279c671e-a239-4f85-af60-4dc832b396d7.gif)

