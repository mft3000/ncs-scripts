import ncs.maapi
import ncs.maagic
from ncs.dp import Action
import json, argparse
from collections import defaultdict 

def tree(): 
	return defaultdict(tree)
	
class addHost(object):

	json = tree()
	file = ''
	
	def __init__(self, file=''):
		self.file = file
		self.file_to_json()
		
	def file_to_json(self):
	
		with open(self.file) as lines:
			for i,line in enumerate(lines):
				line = line.strip()
				# print line.split(',')
				
				self.json[i]["name"] = line.split(',')[0]
				self.json[i]["ip"] =  line.split(',')[1]
				self.json[i]["port"] = line.split(',')[2]
				self.json[i]["auth"] = line.split(',')[3]
				self.json[i]["ne_type"] = line.split(',')[4]
				self.json[i]["ned_id"] = line.split(',')[5]
				self.json[i]["protocol"] = line.split(',')[6]
				self.json[i]["state"] = line.split(',')[7]
		
	def write_nso(self):
		with ncs.maapi.Maapi() as m:
			with ncs.maapi.Session(m, 'admin', 'python'):
				with m.start_write_trans() as t:
					root = ncs.maagic.get_root(t)
										
					for i in self.json:
						root.devices.device.create(self.json[i]["name"])
						root.devices.device[self.json[i]["name"]].address = self.json[i]["ip"]
						root.devices.device[self.json[i]["name"]].port = int(self.json[i]["port"])
						root.devices.device[self.json[i]["name"]].authgroup = self.json[i]["auth"]
						# root.devices.device[self.json[i]["name"]].device_type.ne_type = self.json[i]["ne_type"]
						root.devices.device[self.json[i]["name"]].device_type.cli.create()
						root.devices.device[self.json[i]["name"]].device_type.cli.ned_id = 'ios-id:' + self.json[i]["ned_id"]
						root.devices.device[self.json[i]["name"]].device_type.cli.protocol = self.json[i]["protocol"]
						root.devices.device[self.json[i]["name"]].state.admin_state = str(self.json[i]["state"])
						
					t.apply()

						
def main():
	parser = argparse.ArgumentParser(description='')
	parser.add_argument('-f','--file', default='add.conf', help='')
	
	args = parser.parse_args()
	
	H = addHost(args.file)
	H.write_nso()
	
	
if __name__ == "__main__":
	main()