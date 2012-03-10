from twisted.internet.protocol import Factory, Protocol
from twisted.internet.endpoints import TCP4ServerEndpoint
from twisted.internet import reactor
import MySQLdb


class Echo(Protocol):
  def dbSetupAndRun(self):
    conn = MySQLdb.connect(host = "localhost",
                            user = "root",
                            passwd = "",
                            db = "benchmark")
    cursor = conn.cursor()
    cursor.execute("SELECT name, email_address FROM user, profile WHERE profile.id = user.profile_id")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    self.sendResp(rows)

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
