from twisted.internet.protocol import Factory, Protocol
from twisted.internet.endpoints import TCP4ServerEndpoint
from twisted.internet import reactor

class Echo(Protocol):
  def fibonacci(self, n):
    fibminus2 = 0
    fibminus1 = 1
    fib = 0

    if n == 0 or n == 1:
      self.sendResp(n)
    for n in range(2, n+1):
      fib = fibminus1 + fibminus2
      fibminus2 = fibminus1
      fibminus1 = fib
    self.sendResp(fib)

  def connectionMade(self):
    self.fibonacci(20)

  def sendResp(self, n):
    self.transport.write("Fibonacci: " + str(n))
    self.transport.loseConnection()

class EchoFactory(Factory):
  protocol = Echo
  def buildProtocol(self, addr):
    return Echo()

  def __init__(self, quote=None):
    self.quote = quote or 'An apple a day keeps the doctor away'

endpoint = TCP4ServerEndpoint(reactor, 8000)
endpoint.listen(EchoFactory())
reactor.run()
