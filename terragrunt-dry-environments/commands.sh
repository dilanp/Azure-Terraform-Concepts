#  Duplicate production environment code into development environment.
cp -p -a ./production/. ./development/

# Replace variables for the NEW development environment.
sed -i 's/calabserver/calabdevserver/g' ./development/environment_vars.yaml \
&& sed -i 's+10.0.0.0/16+10.1.0.0/16+g' ./development/environment_vars.yaml \
&& sed -i 's+10.0.0.0/24+10.1.0.0/24+g' ./development/environment_vars.yaml 