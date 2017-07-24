# What is this Template?
<p>This is a template to every new game that will be added to Remar.</p>
<p>The basic changes (such as Spring Security configs, dependencies, Mongo, materialize, etc) were all done here.</p>

# Why do we have this Template?
<p>When creating a new project to add into Remar, this is a base project to copy from to start working on what you really need to and not waste your time with basic configurations.</p>

## How to use it:
<p>Copy this project changing its name into the name of your new application that will be added into Remar.</p>
<p>You will need however to make a few changes in the code before using it.</p>

### Changes needed:
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
