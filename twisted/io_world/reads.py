from twisted.internet.protocol import Factory, Protocol
from twisted.internet.endpoints import TCP4ServerEndpoint
from twisted.internet import reactor
import MySQLdb
import os


class Echo(Protocol):
  def connectionMade(self):
    conn = MySQLdb.connect(host = os.environ[ 'BENCHMARK_HOST' ],
                            user = os.environ[ 'BENCHMARK_USER' ],
                            passwd = os.environ[ 'BENCHMARK_PASS' ],
                            db = os.environ[ 'BENCHMARK_DB' ])
    cursor = conn.cursor()
    cursor.execute("SELECT name, email_address FROM user, profile WHERE profile.id = user.profile_id")
    rows = str(cursor.fetchall())
    conn.commit()
    cursor.close()
    conn.close()
    self.transport.write(rows)
    self.transport.loseConnection()

class EchoFactory(Factory):
  protocol = Echo
  def buildProtocol(self, addr):
    return Echo()

#endpoint = TCP4ServerEndpoint(reactor, 8000)
reactor.listenTCP(8000, EchoFactory())
reactor.run()
