FROM analyticsbase

RUN apt-get update
RUN apt-get install -y nodejs npm && \
	ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g bower
RUN sudo npm install http-server -g

RUN git clone https://github.com/att-innovate/charmander-vector.git && \
	cd charmander-vector && \
	git checkout 2ce96b97dc7de210eea594c6bcba7ae6365f189d

RUN cd charmander-vector && \
	bower --allow-root install --config.interactive=false && \
	npm install && \
	npm install --global gulp && \
	gulp

EXPOSE 10000

ENTRYPOINT ( cd charmander-vector/dist && http-server --cors -p 10000 )
