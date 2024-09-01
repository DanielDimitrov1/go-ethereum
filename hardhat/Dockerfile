FROM ethereum/client-go:alltools-latest

COPY hardhat.config.js .
COPY scripts/sample-script.js .

RUN npm ci

CMD ["npx", "hardhat", "run", "scripts/sample-script.js", "--network", "localhost"]
