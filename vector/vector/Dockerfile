FROM analyticsbase

RUN apt-get update
RUN apt-get install -y nodejs npm && \
	ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g bower
RUN sudo npm install http-server -g

RUN git clone https://github.com/att-innovate/charmander-vector.git && \
	cd charmander-vector && \
	git checkout 4e2d64ca2ae04c72b90e8544cc9db1ae4c03c91d

RUN cd charmander-vector && \
	bower --allow-root install --config.interactive=false && \
	npm install && \
	npm install --global gulp && \
	gulp

EXPOSE 10000

ENTRYPOINT ( cd charmander-vector/dist && http-server --cors -p 10000 )
