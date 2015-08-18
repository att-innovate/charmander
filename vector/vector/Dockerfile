FROM analyticsbase

RUN apt-get update
RUN apt-get install -y nodejs npm && \
	ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g bower
RUN sudo npm install http-server -g

RUN git clone https://github.com/att-innovate/charmander-vector.git && \
	cd charmander-vector && \
	git checkout 2c72f4cacf6b60a8fb07cb3ff15965ab0063f78a

RUN git clone https://github.com/att-innovate/charmander-vector-extensions.git

RUN cp $(pwd)/charmander-vector-extensions/containerResolver.js $(pwd)/charmander-vector/src/app &&\
	cd charmander-vector && \
	bower --allow-root install --config.interactive=false && \
	npm install && \
	npm install --global gulp && \
	gulp

EXPOSE 10000

ENTRYPOINT ( cd charmander-vector/dist && http-server --cors -p 10000 )
