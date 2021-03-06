curl -XPUT localhost:9200/_template/logstash01 -d '
{  
   "template":"logstash-*",
   "settings":{  
      "number_of_shards":2,
      "number_of_replicas":0,
      "index":{  
         "refresh_interval":"30s",
         "similarity":{  
            "default":{  
               "type":"classic"
            }
         }
      }
   },
   "mappings":{  
      "ossec":{  
         "_all":{  
            "enabled":false,
            "norms":false
         },
         "dynamic_templates":[  
            {  
               "string_fields":{  
                  "match_mapping_type":"string",
                  "mapping":{  
                     "fields":{  
                        "raw":{  
                           "index":true,
                           "ignore_above":256,
                           "type":"keyword"
                        }
                     },
                     "index":true,
		     "analyzer": "keyword",
                     "omit_norms":true,
                     "type":"text"
                  }
               }
            }
         ],
         "properties":{  
            "full_log":{  
               "index": false,
	       "type": "text"
            }

      }
	 },
      "nginx":{  
         "_all":{  
            "enabled":false,
            "norms":false
         },
         "dynamic_templates":[  
            {  
               "string_fields":{  
                  "match_mapping_type":"string",
                  "mapping":{  
                     "fields":{  
                        "raw":{  
                           "index":true,
                           "ignore_above":256,
                           "type":"keyword"
                        }
                     },
                     "index":true,
                     "omit_norms":true,
		     "analyzer": "keyword",
                     "type":"text"
                  }
               }
            }
         ],
         "properties":{  
            "@timestamp":{  
               "type":"date"
            }

         }
      },
      "_default_":{  
         "_all":{  
            "enabled":false,
            "norms":false
         },
         "dynamic_templates":[  
            {  
               "string_fields":{  
                  "match":"*",
                  "match_mapping_type":"string",
                  "mapping":{  
                     "fields":{  
                        "raw":{  
                           "index":true,
                           "ignore_above":256,
                           "type":"keyword"
                        }
                     },
                     "index":true,
                     "analyzer":"keyword",
                     "omit_norms":true,
                     "type":"text"
                  }
               }
            }
         ],
         "properties":{  
            "@version":{  
               "type":"keyword"
            },
            "geoip":{  
               "dynamic":"true",
               "properties":{  
                  "location":{  
                     "type":"geo_point"
                  }
               }
            }
         }
      }
   }
}'
