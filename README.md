Docker image that allows you to host apache with php modules easily.

Notes-
I edited the original apache conf to not include Indexes and edited Documentroot to be in /var/www. If you need other things edit this file then build the image.


How to use-
Pretty simple


docker run -d -p 8080:80 --name=your-php-app -v /dir/that/hosts/your/php/:/var/www buildimagename

Above command will host your php app from your host's directory (/dir/that/hosts/your/php) into the Documentroot (/var/www/) on port 8080
