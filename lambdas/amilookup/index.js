/**
* A Lambda function that looks up the latest AMI ID for a given region, owner
* and prefix.
**/

// Load AWS SDK
var aws = require("aws-sdk");

exports.handler = function(event, context) {

    console.log("REQUEST RECEIVED:\n" + JSON.stringify(event));

    // For Delete requests, immediately send a SUCCESS response.
    if (event.RequestType == "Delete") {
        sendResponse(event, context, "SUCCESS");
        return;
    }
    var responseStatus = "FAILED";
    var responseData = {};

    // Filter AMIs
    var ec2 = new aws.EC2({region: event.ResourceProperties.Region});
    var describeImagesParams = {
        Filters: [{ Name: "name", Values: [event.ResourceProperties.Prefix]}],
        Owners: event.ResourceProperties.Owners
    };
    var trustyImagesParams = {
        Filters: [{ Name: "name", Values: ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64*"]}],
        Owners: ["099720109477"]
    };

    // Get AMI IDs with the specified name pattern and owner
    ec2.describeImages(describeImagesParams, function(err, describeImagesResult) {
        if (err) {
            responseData = {Error: "DescribeImages call failed"};
            console.log(responseData.Error + ":\n", err);
        }
        else {
            var images = describeImagesResult.Images;
            // Sort images by name in descending order. The names contain the
            // AMI version, formatted as yyyymmddhhMMss.
            images.sort(function(x, y) { return y.Name.localeCompare(x.Name); });
            for (var j = 0; j < images.length; j++) {
                if (isBeta(images[j].Name)) continue;
                responseStatus = "SUCCESS";
                responseData["Id"] = images[j].ImageId;
                break;
            }
        }
        if (!responseData["Id"]) {
            ec2.describeImages(trustyImagesParams, function(err, describeImagesResult) {
                var images = describeImagesResult.Images;
                // Sort images by name in descending order. The names contain the
                // AMI version, formatted as yyyymmddhhMMss.
                images.sort(function(x, y) { return y.Name.localeCompare(x.Name); });
                for (var j = 0; j < images.length; j++) {
                    responseStatus = "SUCCESS";
                    responseData["Id"] = images[j].ImageId;
                    break;
                }
                console.log("Found official Trusty AMI: " + responseData["Id"]);
                sendResponse(event, context, responseStatus, responseData);
            });
        } else {
            console.log("Found custom AMI: " + responseData["Id"]);
            sendResponse(event, context, responseStatus, responseData);   
        }
    });
};

// Check if the image is a beta or rc image. The Lambda function won't return
// any of those images.
function isBeta(imageName) {
    return imageName.toLowerCase().indexOf(".beta") > -1 || imageName.toLowerCase().indexOf(".rc") > -1;
}

// Send response to the pre-signed S3 URL
function sendResponse(event, context, responseStatus, responseData) {

    var responseBody = JSON.stringify({
        Status: responseStatus,
        Reason: "See the details in CloudWatch Log Stream: " + context.logStreamName,
        PhysicalResourceId: context.logStreamName,
        StackId: event.StackId,
        RequestId: event.RequestId,
        LogicalResourceId: event.LogicalResourceId,
        Data: responseData
    });

    console.log("RESPONSE BODY:\n", responseBody);

    var https = require("https");
    var url = require("url");

    var parsedUrl = url.parse(event.ResponseURL);
    var options = {
        hostname: parsedUrl.hostname,
        port: 443,
        path: parsedUrl.path,
        method: "PUT",
        headers: {
            "content-type": "",
            "content-length": responseBody.length
        }
    };

    console.log("SENDING RESPONSE...\n");

    var request = https.request(options, function(response) {
        console.log("STATUS: " + response.statusCode);
        console.log("HEADERS: " + JSON.stringify(response.headers));
        // Tell AWS Lambda that the function execution is done
        context.done();
    });

    request.on("error", function(error) {
        console.log("sendResponse Error:" + error);
        // Tell AWS Lambda that the function execution is done
        context.done();
    });

    // write data to request body
    request.write(responseBody);
    request.end();
}
