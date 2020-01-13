import logging #reused code
from time import sleep #reused code
from datetime import timedelta

import stomp #reused code
import json
import psycopg2
import time, datetime

#connect to database
try:
    conn = psycopg2.connect("dbname='networkraildb' user='YOUR DB NAME' host='networkraildbinstance.cteyflen9oes.us-east-2.rds.amazonaws.com' password='YOUR PASSWORD'")
    #conn = psycopg2.connect("dbname='<YOUR DATABASE NAME>' user='<YOUR USER NAME>' host='<YOUR HOST NAME>' password='<YOUR PASSWORD>'")
except:
    print ('Unable to connect to DB')

NETWORK_RAIL_AUTH = ('YOUR EMAIL', 'YOUR PASSWORD')

class Listener(object):

    def __init__(self, mq): #reused code
        self._mq = mq #reused code

    def on_message(self, headers, message): #reused code
        #print headers
        #print message
        message_array = json.loads(message)

        for s in message_array:
            if s['header']['msg_type'] == '0003': #if message type is 0003 (Train Movement feed) then print the data from body
            #if s['header']['msg_type'] == '0003':
                print (s['body'])

                event_type = s['body']['event_type']

                if s['body']['gbtt_timestamp'] == '':
                    gbtt_timestamp = None
                else:
                    gbtt_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['gbtt_timestamp'])/1000) - timedelta(hours=1)) 
                    #Formats data into DD/MM/YYYY HH:MM:SS AND subtracts an hour from the received time as it's in GMT Time so BST Time needs to be manually calculated 

                """
                if s['body']['gbtt_timestamp'] == '':
                    gbtt_timestamp = None
                else:
                    gbtt_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['gbtt_timestamp'])/1000)) #Formats data into DD/MM/YYYY HH:MM:SS
                """

                original_loc_stanox = s['body']['original_loc_stanox']

                if s['body']['planned_timestamp'] == '':
                    planned_timestamp = None
                else:
                    planned_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['planned_timestamp']) / 1000) - timedelta(hours=1))
                    #Formats data into DD/MM/YYYY HH:MM:SS AND subtracts an hour from the received time as it's in GMT Time so BST Time needs to be manually calculated 
                          
                    #planned_timestamp = (datetime.datetime.fromtimestamp(int(s['body']['planned_timestamp']) / 1000) - timedelta(hours=1) #working alternative code to above but not used
                    #planned_timestamp = str(datetime.datetime.fromtimestamp(int(s['body']['planned_timestamp']) / 1000) - timedelta(hours=1)) #working alternative code to above but not used    
                             
                    #onehourbackwards = s['body']['planned_timestamp'] - timedelta(hours=1) #not working alternative code to above and not used 
                    #planned_timestamp = str(datetime.datetime.fromtimestamp(float(onehourbackwards)/1000)) #not working alternative code to above and not used 
                    #planned_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['planned_timestamp'])/1000) � timedelta(hours=1)) #not working alternative code to above and not used 
                    
                    #onehourbackwards = str(datetime.datetime.fromtimestamp(float(s['body']['planned_timestamp'])/1000)) #not working alternative code to above and not used 
                    #planned_timestamp = onehourbackwards - timedelta(hours=1) #not working alternative code to above and not used           
                                                                                                                      
                """
                if s['body']['planned_timestamp'] == '':
                    planned_timestamp = None
                else:
                    planned_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['planned_timestamp'])/1000)) #Formats data into DD/MM/YYYY HH:MM:SS
                """

                timetable_variation = s['body']['timetable_variation']

                if s['body']['original_loc_timestamp'] == '':
                    original_loc_timestamp = None
                else:
                    original_loc_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['original_loc_timestamp'])/1000) - timedelta(hours=1))
                    #Formats data into DD/MM/YYYY HH:MM:SS AND subtracts an hour from the received time as it's in GMT Time so BST Time needs to be manually calculated 

                """
                if s['body']['original_loc_timestamp'] == '':
                    original_loc_timestamp = None
                else:
                    original_loc_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['original_loc_timestamp'])/1000)) #Formats data into DD/MM/YYYY HH:MM:SS
                """

                current_train_id = s['body']['current_train_id']
                delay_monitoring_point = s['body']['delay_monitoring_point']
                
                next_report_run_time = s['body']['next_report_run_time']
                
                #if s['body']['next_report_run_time'] == '':
                #    next_report_run_time = "0"
                #else:
                #    next_report_run_time = s['body']['next_report_run_time']
                
                reporting_stanox = s['body']['reporting_stanox']
                
                if s['body']['actual_timestamp'] == '':
                    actual_timestamp = None
                else:
                    actual_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['actual_timestamp'])/1000) - timedelta(hours=1))
                    #Formats data into DD/MM/YYYY HH:MM:SS AND subtracts an hour from the received time as it's in GMT Time so BST Time needs to be manually calculated 

                """
                if s['body']['actual_timestamp'] == '':
                    actual_timestamp = None
                else:
                    actual_timestamp = str(datetime.datetime.fromtimestamp(float(s['body']['actual_timestamp'])/1000)) #Formats data into DD/MM/YYYY HH:MM:SS
                """

                correction_ind = s['body']['correction_ind']
                event_source = s['body']['event_source']
                train_file_address = s['body']['train_file_address']
                platform =  s['body']['platform']
                division_code = s['body']['division_code']
                train_terminated = s['body']['train_terminated']
                train_id = s['body']['train_id']
                offroute_ind = s['body']['offroute_ind']
                variation_status = s['body']['variation_status']
                train_service_code = s['body']['train_service_code']
                toc_id = s['body']['toc_id']
                #loc_stanox = s['body']['loc_stanox']
                
                #start_of_string = "0" #testing
                #start_of_string.startswith("hello") #testing
                           
                if s['body']['loc_stanox'].startswith("0"): #if the current location stanox starts with 0
                    loc_stanox = s['body']['loc_stanox'][1:] #then write every character except the 0 to db
                else:
                    loc_stanox = s['body']['loc_stanox']   

                if s['body']['auto_expected'] == '': #TO WRITE COMMENT ON EXPLAINATION AFTER THIS POINT 
                    auto_expected = None
                else:
                    auto_expected = s['body']['auto_expected']
                    
                direction_ind = s['body']['direction_ind']
                route = s['body']['route']
                planned_event_type = s['body']['planned_event_type']
                #next_report_stanox = s['body']['next_report_stanox']
                
                if s['body']['next_report_stanox'].startswith("0"): #if the next location stanox starts with 0
                    next_report_stanox = s['body']['next_report_stanox'][1:] #then write every character except the 0 to db
                else:
                    next_report_stanox = s['body']['next_report_stanox']  
                
                line_ind = s['body']['line_ind']

                c = conn.cursor()
                #inserts data into database
                c.execute("INSERT INTO NetworkRail (event_type, gbtt_timestamp, original_loc_stanox, planned_timestamp, timetable_variation, original_loc_timestamp, current_train_id, delay_monitoring_point, next_report_run_time, reporting_stanox, actual_timestamp, correction_ind, event_source, train_file_address, platform, division_code, train_terminated, train_id, offroute_ind, variation_status, train_service_code, toc_id, loc_stanox, auto_expected, direction_ind, route, planned_event_type, next_report_stanox, line_ind) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                    (event_type, gbtt_timestamp, original_loc_stanox, planned_timestamp, timetable_variation, original_loc_timestamp, current_train_id, delay_monitoring_point, next_report_run_time, reporting_stanox, actual_timestamp, correction_ind, event_source, train_file_address, platform, division_code, train_terminated, train_id, offroute_ind, variation_status, train_service_code, toc_id, loc_stanox, auto_expected, direction_ind, route, planned_event_type, next_report_stanox, line_ind))

                conn.commit()

        self._mq.ack(id=headers['message-id'], subscription=headers['subscription']) #reused code

while True:
    try:
        mq = stomp.Connection(host_and_ports=[('datafeeds.networkrail.co.uk', 61618)], #reused code
                              keepalive=True, #reused code
                              vhost='datafeeds.networkrail.co.uk', #reused code
                              heartbeats=(100000, 50000)) #reused code

        mq.set_listener('', Listener(mq)) #reused code

        mq.start() #reused code
        mq.connect(username=NETWORK_RAIL_AUTH[0], #reused code
                   passcode=NETWORK_RAIL_AUTH[1], #reused code
                   wait=True) #reused code

        mq.subscribe('/topic/TRAIN_MVT_ALL_TOC', 'test-vstp', ack='client-individual') #reused code
        #mq.subscribe('/topic/TRAIN_MVT_ALL_TOC', 'test-vstp', ack='client-individual')

        while mq.is_connected(): #reused code
            sleep(1) #reused code

    except:
        # Reconnect and continue
        continue