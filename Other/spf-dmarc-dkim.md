# Setup SPF, DMARC, and DKIM to avoid email spoofing

Guide inspired by this article: <https://simonandrews.ca/articles/how-to-set-up-spf-dkim-dmarc>

The following example is for an email registered with Microsoft 365.

## SPF

On your DNS secords add a __TXT__ record which will include the following values: ```v=spf1 include:spf.protection.outlook.com -all```

* ```v=spf1```: Declares this as an SPF record
* ```include:spf.protection.outlook.com```: Emails are allowed to be sent from ```spf.protection.outlook.com``` only
* ```-all```: Deny other domains and allow only the ones included in this record. DO NOT FORTGET ABOUT THE DASH, THAT MEANS DENY ALL. IF YOU USE ```~all``` OR ```?all``` INSTEAD OF ```-all```, the SPF RECORD WON'T DO MUCH

You must do it for each subdomain if you send emails from them.

## DKIM

Usually the email provider will give you instructions on how to set DKIM, follow them to the letter.

The DKIM record can be a ```TXT``` record conaining the key: ```selector1._domainkey.example.com``` value ```v=DKIM1; k=rsa; p=domain-key```.  
Alternatively it can be a ```CNAME``` record which points to a public key of the provider.

## DMARC

Create a ```TXT``` record with the name ```_dmarc.example.com``` and give it the following possible values:

* ```v=DMARC1```: Identifies the record retrieved as a DMARC record. It must be the first tag in the list
* ```p=reject```: Policy to apply to email that fails the DMARC test. Valid values can be *none*, *quarantine*, or *reject*.
* ```pct=100```: Percentage of messages from the Domain Owner's mail stream to which the DMARC policy is to be applied. Valid value is an integer between 0 to 100
* ```sp=none```: Sub-domain Policy. Requested Mail Receiver policy for all subdomains. Valid values can be *none*, *quarantine*, or *reject*
* ```adkim=s```: Alignment Mode DKIM. Indicates whether strict or relaxed DKIM Identifier Alignment mode is required by the Domain Owner. Valid values can be *r* (relaxed) or *s* (strict mode)
* ```aspf=r```: Alignment Mode SPF. Indicates whether strict or relaxed SPF Identifier Alignment mode is required by the Domain Owner. Valid values can be *r* (relaxed) or *s* (strict mode)
* ```fo=0```: Forensic reporting. Provides requested options for generation of failure reports. Valid values are any combination of characters ```01ds``` seperated by ```:```
  * fo=0: Generate a DMARC failure report if all underlying authentication mechanisms (SPF and DKIM) fail to produce an aligned “pass” result. (Default)
  * fo=1: Generate a DMARC failure report if any underlying authentication mechanism (SPF or DKIM) produced something other than an aligned “pass” result. (Recommended)
  * fo=d: Generate a DKIM failure report if the message had a signature that failed evaluation, regardless of its alignment.
  * fo=s: Generate an SPF failure report if the message failed SPF evaluation, regardless of its alignment.
* ```rf=afrf```: Forensic Format. Format to be used for message-specific failure reports. Valid values are *afrf* and *iodef*
* ```ri=86400```: Reporting Interval. Indicates a request to Receivers to generate aggregate reports separated by no more than the requested number of seconds. Valid value is a 32-bit unsigned integer.
* ```ruf=mailto:postmaster@example.com```: Forensic Receivers. Addresses to which message-specific failure information is to be reported. Comma separated values
* ```rua=mailto:postmaster@example.com```: Receivers. Addresses to which aggregate feedback is to be sent. Comma separated values

Example: ```v=DMARC1;p=reject;sp=none;adkim=s;aspf=r;pct=100;fo=0;rf=afrf;ri=86400;ruf=mailto:postmaster@example.com```
