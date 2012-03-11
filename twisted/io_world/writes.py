from twisted.internet.protocol import Factory, Protocol
from twisted.internet.endpoints import TCP4ServerEndpoint
from twisted.internet import reactor
import MySQLdb


class Echo(Protocol):
  def dbSetupAndRun(self):
    conn = MySQLdb.connect(host = os.environ[ 'BENCHMARK_HOST' ],
                            user = os.environ[ 'BENCHMARK_USER' ],
                            passwd = os.environ[ 'BENCHMARK_PASS' ],
                            db = os.environ[ 'BENCHMARK_DB' ])
    cursor = conn.cursor()
    for x in range(1000):
      cursor.execute("INSERT INTO user (name, profile_id) VALUES ('Twisted', 4)")
    conn.commit()
    cursor.close()
    conn.close()
    self.sendResp("Finished Twisted Inserts!")

  def connectionMade(self):
    self.dbSetupAndRun()

  def sendResp(self, data):
    self.transport.write(str(data))
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
