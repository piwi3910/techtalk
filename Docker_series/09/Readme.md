# Dockerfile for beginners

In this episode we will go over some of the most common commands in the dockerfile
and we will also follow a 5 step workflow to conainerize most applications.

## Step 1: Run it baby!
In this step we just put together the boiler plate code in the dockerfile.
we specify:
* FROM
* maintainer via LABELS
* RUN commands to install and run our application

## Step 2: Optimize it!
In this step we collaps multiple single RUN commands in to single lines as such minimizing the number of layer that are being created
We also set some variables that could be needed.

## Step 3: Entrypoints are it!
In this step we now move our applications RUN command to an entrypoint
we also specify any ports needed for the application to run.
We create a separate entrypoint start script that will run our application

## Step 4: Persist it!
As we have now seen that our application saves a lof of files for ourt game server in the same directory as our executable, we now change our entrypoint file a bit to download the executable on container run and not build.
This makes our container smaller and allows us to first mount a volume so that we can persist all data.

## Step 5: Secure it!
We now have a running application, now lets make it secure.
We now create a user our application will run as, and make sure all files needed can be accessed.

