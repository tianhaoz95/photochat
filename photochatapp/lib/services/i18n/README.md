# I18n Support

I18n support should be implemented as a service provider to the app which has the following APIs:

* Set the preferred locale
* Retrieve messages with preferred locale

In addition, it should:

* Notify listeners of locale changes

Note:

I18n component shouldn't by nature have anything to do with a service provider for flexibility. Therefore, the design should have this in mind and implement I18n as a class without any assumption of service provider and then wrap this class in a service provider.