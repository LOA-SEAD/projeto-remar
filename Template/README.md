# What is this Template?
<p>This is a template to every new game that will be added to Remar.</p>
<p>The basic changes (such as Spring Security configs, dependencies, Mongo, materialize, etc) were all done here.</p>

# Why do we have this Template?
<p>When creating a new project to add into Remar, this is a base project to copy from to start working on what you really need to and not waste your time with basic configurations.</p>

## How to use it:
<p>Copy this project changing its name into the name of your new application that will be added into Remar.</p>
<p>You will need however to make a few changes in the code before using it.</p>

### Next steps:
* Run this command inside this repository's base directory in your computer:
```
cd /path/to/projeto-remar
cp -rf Template/ *your_application_name_here*
rm *your_application_name_here*/Manual.pdf *your_application_name_here*/README.md
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
This will create  a directory with the name of your application.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Then you can open IntelliJ and go to **New->Project from Existing Sources** and select the directory you just created and start working on it :)

* grails-app/conf/**Config.groovy**
<br> Substitute the *"TemplateName"* to your application's name where you find the following line (2 occurrences)
```java
grails.app.context = "/TemplateName"
```

* grails-app/conf/**Datasource.groovy**
<br> Substitute the *"TemplateName"* to your application's name where you find the following line (3 occurrences)
```java
url = "jdbc:mysql://localhost/TemplateName"
```
* Remember that inside the dir "**web-app/remar**"  many other changes will be needed. Those are better explained at the [Manual.pdf](https://github.com/LOA-SEAD/projeto-remar/blob/master/Template/Manual.pdf) file inside this repository.

* Now you are all set to start working into your grails-app directory and bring your new game to the Remar platform!

