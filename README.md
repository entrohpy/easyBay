# EasyBay
*A one-stop shopping app that uses object localization and ML scam detection to provide secure eBay results.*
**Built for Hacktech 2019 | Won sponsored prize by eBay**

Link: https://devpost.com/software/easybay-ts2gwo

## Inspiration
How often did you really want to impulsively buy a cute outfit or a sleek usb to usb-c convertor that your friend has, only to realize that they bought it for a really high price? We have felt this too often. So naturally, easyBay was the best solution to our problems.


## What It Does
The user may take a photo or use an existing one and our app will automatically identify the plausible items and provide a list of items from eBay that match their specifications the best, while simultaneously also removing any scam sellers from the search. easyBay is capable of using Google Cloud's Vision API and its own ML based scam detector to search an image for the least expensive, but most secure buying options on eBay. easyBuy then provides you with listings from eBay that best match your search criteria, also notifying you of potential scam listings.


## How We Built It
**Google Cloud Vision API**

**Keras**

**eBay APIs**

Finding API
Browse API
Shopping API
We built easyBay as an iOS app , which we built on Xcode with Swift. The app fetched the required data by making the necessary API calls using the URLRequest and URLSession built-in protocol. The eBay API is essential to this application. Its Finding API and Shopping AI allowed us to get more information on the sellers and the specifics of the products that they sell.

We then passed this data using our ML model which could then make an accurate prediction of the "suspicion rating" of the seller. This was an ML model that we built form scratch using Keras and Tensorflow. We trained it on data received from eBay POST requests and did extensive research on string indicators of scam sellers. In this process, we also took into account some guidelines and tips to avoid scams laid out by eBay in their official documentation. This feature is essential for users who would like to only deal with unsuspicious and non-fraudulent sellers, which is often a major problem for users shopping on eBay.

We also extensively used the Browse API that enabled the app search by image giving the user seamless experience. It also enabled us to create one of the most important features of the app: the image search. However, it is not just any ordinary image search. We first pass the user's image to Google Cloud's Vision API which locates and classifies objects. We crop the images based on the data returned and then, pass those to the eBay Browse API that locates EACH object in the picture. Furthermore, you can also add filters to your search for example, a budget (price), delivery postal code, For example, say you loved the clothes your friend is wearing but you you have a slim budget? No problem, because EasyBay lets you quickly take a picture of your friend and search for all clothing items available at the budget you selected!

## What's Next for easyBay
There were numerous features we wanted to add for easyBay but ran out of time for. One of the most prominent was to add the ability for the user to purchase the item they liked straight from our app using Ebay’s Buy API.  This way our app acts as the start point and end point of the user experience from uploading or taking a picture to completing the payment on the app. We also hope to improve the accuracy of our eBay product listings by being able to filter out repetitive images from our Google Cloud Vision software. Due to the nested structure of our vision processing, there are a decent amount of duplicate images as a by product. Our goal is to find a way to remove those duplicates in order to make easyBay more efficient and more accurate. One major feature we want to implement in the future is the usage of easyBay as a means of finding stolen items. Through additional user information and eBay’s reverse image search, we want to be able to pinpoint a user’s item that has been stolen and is being resold on eBay. One example is with MacBooks. Every MacBook has a serial number and many listings on eBay would list the serial number in order to gain validity. Our application would take the user’s picture of their Mac and reverse search it and compare the serial numbers to see if the user’s laptop is being resold on eBay
