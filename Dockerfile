FROM dockcross/windows-x86
MAINTAINER Alexander Wellbrock <alexander.wellbrock@cs.hs-fulda.de>

ENV BWAPI_VERSION=4.1.2
ENV BWTA_VERSION=2.2

# Include the VS 2013 pre-build version of bwapi 412
# These are the contents of the official installer
ENV BWAPI_DIR /tmp/bwapi
RUN echo "export BWAPI_DIR=$BWAPI_DIR" >> /root/.bashrc
RUN curl -L https://github.com/lionax/bwapi/releases/download/v4.1.2/BWAPI-4.1.2.zip -o /tmp/bwapi.zip \
   && unzip /tmp/bwapi.zip -d $BWAPI_DIR \
      && mv $BWAPI_DIR/BWAPI/* $BWAPI_DIR \
      && rm -R $BWAPI_DIR/BWAPI \
      && rm /tmp/bwapi.zip \
      && chmod 755 -R $BWAPI_DIR

ENV BWTA_DIR /tmp/bwta2
RUN curl -L https://bitbucket.org/auriarte/bwta2/downloads/BWTAlib_2.2.7z -o $BWTA_DIR.7z \
   && 7za x -o$BWTA_DIR $BWTA_DIR.7z \
      && rm $BWTA_DIR.7z \
      && mv $BWTA_DIR/BWTAlib_2.2/* $BWTA_DIR \
      && rm -R $BWTA_DIR/BWTAlib_2.2 \
      && chmod 755 -R $BWTA_DIR \
   && echo "export BWTA_DIR=$BWTA_DIR" >> /root/.bashrc

ENV RAPIDJSON_DIR /tmp/rapidjson
RUN curl -L https://github.com/miloyip/rapidjson/archive/v1.1.0.tar.gz -o $RAPIDJSON_DIR.tar.gz \
      && mkdir $RAPIDJSON_DIR \
      && tar -xf $RAPIDJSON_DIR.tar.gz -C $RAPIDJSON_DIR \
      && rm $RAPIDJSON_DIR.tar.gz \
      && mv $RAPIDJSON_DIR/rapidjson-1.1.0/* $RAPIDJSON_DIR \
      && rm -R $RAPIDJSON_DIR/rapidjson-1.1.0 \
      && chmod 755 -R $RAPIDJSON_DIR \
   && echo "export RAPIDJSON_DIR=$RAPIDJSON_DIR" >> /root/.bashrc

# Call a check-version script to check all build in libraries for newer versions
# ENTRYPOINT ['check-version']