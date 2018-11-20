class LocalAuthority::Gateway::ACReturnsSchemaTemplate
  def execute
    @return_template = Common::Domain::Template.new.tap do |p|
      p.schema = {
        title: 'AC Project',
        type: 'object',
        properties: {
          sites: {
            type: 'array',
            title: 'Sites',
            items: {
              type: 'object',
              title: 'Site',
              properties: {
                summary: {
                  type: 'object',
                  title: 'Summary',
                  properties: {
                    name: {
                      type: 'string',
                      title: 'Name'
                    },
                    description: {
                      type: 'string',
                      title: 'Description'
                    },
                    baselineunits: {
                      type: 'string',
                      title: 'Units',
                      readonly: true,
                      sourceKey: %i[baseline_data summary sitesSummary units numberOfUnitsTotal]
                    },
                    affordableHousingUnits: {
                      type: 'string',
                      title: 'Affordable Housing Units',
                      readonly: true,
                      sourceKey: %i[baseline_data summary sitesSummary units numberOfUnitsAffordable]
                    },
                    totalNoOfUnits: {
                      type: 'string',
                      title: 'Total number of units',
                      readonly: true
                    },
                    planningStatus: {
                      type: 'string',
                      title: 'Planning Status',
                      readonly: true
                    }
                  }
                },
                housingOutputs: {
                  type: 'object',
                  title: 'Housing Outputs',
                  properties: {
                    baselineunits: {
                      type: 'string',
                      title: 'Units',
                      readonly: true,
                      sourceKey: %i[baseline_data summary sitesSummary units numberOfUnitsTotal]
                    },
                    affordableHousingUnits: {
                      type: 'string',
                      title: 'Affordable Housing Units',
                      readonly: true,
                      sourceKey: %i[baseline_data summary sitesSummary units numberOfUnitsAffordable]
                    },
                    units: {
                      type: 'object',
                      title: 'Units',
                      properties: {
                        numberOfUnitsTotal: {
                          type: 'string',
                          title: 'Total',
                          readonly: true
                        },
                        numberOfUnits: {
                          type: 'object',
                          horizontal: true,
                          title: 'Number of',
                          properties: {
                            numberOfUnitsMarket: {
                              type: 'string',
                              title: 'Market Sale'
                            },
                            numberOfUnitsSharedOwnership: {
                              type: 'string',
                              title: 'Shared Ownership'
                            },
                            numberOfUnitsAffordable: {
                              type: 'string',
                              title: 'Affordable/Social Rent'
                            },
                            numberOfUnitsPRS: {
                              type: 'string',
                              title: 'Private Rented'
                            },
                            numberOfUnitsOther: {
                              type: 'string',
                              title: 'Other'
                            }
                          }
                        },
                        reasonForOther: {
                          type: 'string',
                          extendedText: true,
                          title: 'Explanation of other units, if any?'
                        }
                      }
                    },
                    changesRequired: {
                      type: 'string',
                      enum: ['Do not change the baseline', 'Request change to baseline to match lastest estimates'],
                      radio: true,
                      title: 'Changes to Baseline?'
                    },
                    paceOfConstruction: {
                      type: 'object',
                      title: 'Pace of Construction',
                      properties: {
                        timeBetweenStartAndCompletion: {
                          type: 'object',
                          horizontal: true,
                          title: 'Months from start of first housing unit to completion of final unit.',
                          properties: {
                            baseline: {
                              type: 'string',
                              title: 'Baseline',
                              readonly: true
                            },
                            latestEstimate: {
                              type: 'string',
                              title: 'Lastest Estimate'
                            }
                          }
                        },
                        unitsPerMonth: {
                          type: 'object',
                          horizontal: true,
                          title: 'Months from start of first housing unit to completion of final unit.',
                          properties: {
                            baseline: {
                              type: 'string',
                              title: 'Baseline',
                              readonly: true
                            },
                            latestEstimate: {
                              type: 'string',
                              title: 'Lastest Estimate'
                            }
                          }
                        },
                        reasonForChange: {
                          type: 'string',
                          extendedText: true,
                          title: 'Reason for change/variance, and steps taken to address this.'
                        }
                      }
                    },
                    modernMethodsOfConstruction: {
                      type: 'object',
                      title: 'Modern methods of construction',
                      properties: {
                        categoryA: {
                          type: 'object',
                          title: 'Category A - Volumetric',
                          horizontal: true,
                          properties: {
                            baseline: {
                              type: 'string',
                              title: 'Baseline',
                              readonly: true,
                              sourceKey: %i[baseline_data outputs mmcCategory categoryA]
                            },
                            latestEstimate: {
                              type: 'string',
                              percentage: true,
                              title: 'Lastest Estimate'
                            }
                          }
                        },
                        categoryB: {
                          type: 'object',
                          title: 'Category B - Hybrid',
                          horizontal: true,
                          properties: {
                            baseline: {
                              type: 'string',
                              title: 'Baseline',
                              readonly: true,
                              sourceKey: %i[baseline_data outputs mmcCategory categoryB]
                            },
                            latestEstimate: {
                              type: 'string',
                              title: 'Lastest Estimate',
                              percentage: true
                            }
                          }
                        },
                        categoryC: {
                          type: 'object',
                          title: 'Category C - Panellised',
                          horizontal: true,
                          properties: {
                            baseline: {
                              type: 'string',
                              title: 'Baseline',
                              readonly: true,
                              sourceKey: %i[baseline_data outputs mmcCategory categoryC]
                            },
                            latestEstimate: {
                              type: 'string',
                              title: 'Lastest Estimate',
                              percentage: true
                            }
                          }
                        },
                        categoryD: {
                          type: 'object',
                          title: 'Category D - Sub Assemblies and Components',
                          horizontal: true,
                          properties: {
                            baseline: {
                              type: 'string',
                              title: 'Baseline',
                              readonly: true,
                              sourceKey: %i[baseline_data outputs mmcCategory categoryD]
                            },
                            latestEstimate: {
                              type: 'string',
                              title: 'Lastest Estimate',
                              percentage: true
                            }
                          }
                        },
                        categoryE: {
                          type: 'object',
                          title: 'Category E - No MMC',
                          horizontal: true,
                          properties: {
                            baseline: {
                              type: 'string',
                              title: 'Baseline',
                              readonly: true,
                              sourceKey: %i[baseline_data outputs mmcCategory categoryE]
                            },
                            latestEstimate: {
                              type: 'string',
                              title: 'Lastest Estimate',
                              percentage: true
                            }
                          }
                        },
                        reasonForChange: {
                          type: 'string',
                          extendedText: true,
                          title: 'Reason for change/variance, and steps being taken to address this.'
                        }
                      }
                    }
                  }
                },
                milestonesAndProgress: {
                  type: 'object',
                  title: 'Milestones and Progress',
                  properties: {
                    commencementOfDueDiligence: {
                      type: 'object',
                      title: 'Commencement of surveys and due diligence',
                      properties: {
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                          horizontal: true,
                          type: 'object',
                          title: '',
                          properties: {
                            baselineDate: {
                              type: 'string',
                              format: 'date',
                              title: 'Baseline Date',
                              sourceKey: %i[baseline_data milestones surveysAndDueDiligence commencementOfDueDiligence],
                              readonly: true
                            },
                            currentEstimatedDate: {
                              type: 'string',
                              title: 'Current estimated date',
                              format: 'date'
                            },
                            estimatedPercentageComplete: {
                              type: 'string',
                              title: 'Estimated percentage complete',
                              percentage: true
                            }
                          }
                        },
                        risk: {
                          title: '',
                          type: 'object',
                          horizontal: true,
                          properties: {
                            riskToAchievingBaseline: {
                              type: 'string',
                              title: 'Risk to achieving baseline date',
                              radio: true,
                              enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                            },
                            reasonForVariance: {
                              type: 'string',
                              title: 'Reasn for risk/ variance',
                              extendedText: true
                            }
                          }
                        },
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    completionOfSurveys: {
                      title: 'Completion of surveys and due diligence',
                      type: 'object',
                      properties: {
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      horizontal: true,
                                      type: 'object',
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones surveysAndDueDiligence completionOfSurveys],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    procurementOfWorksCommencementDate: {
                      title: 'Procurement of works commencement date',
                      type: 'object',
                      properties: {                       
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              enum: %w[Yes No],
                              radio: true,
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones procurementProvision procurementOfWorksCommencementDate],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    provisionOfDetailedWorks: {
                      title: 'Provision of detailed works specification and milestones',
                      type: 'object',
                      properties: {                     
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      horizontal: true,
                                      type: 'object',
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones procurementProvision provisionOfDetailedWorks],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    commencementDate: {
                      title: 'Commencement of works date (first, if multiple)',
                      type: 'object',
                      properties: {                      
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones worksDate commencementDate],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    completionDate: {
                      title: 'Completion of works date (last, if multiple)',
                      type: 'object',
                      properties: {                       
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones worksDate completionDate],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    outlinePlanningGrantedDate: {
                      title: 'Outline planning permission granted date',
                      type: 'object',
                      properties: {                      
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    },
                                    planninfReferenceNumber: {
                                      type: 'string',
                                      title: 'Planning Reference Number'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones outlinePlanning outlinePlanningGrantedDate],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    reservedMatterPermissionGrantedDate: {
                      title: 'Reserved Matter Permission Granted date',
                      type: 'object',
                      properties: {                     
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    },
                                    planningReferenceNumber: {
                                      type: 'string',
                                      title: 'Planning Reference Number'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones outlinePlanning reservedMatterPermissionGrantedDate],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    marketingCommenced: {
                      title: 'Developer Partner marketing commenced (EOI or formal tender)',
                      type: 'object',
                      properties: {                  
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones marketingCommenced],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }

                    },
                    conditionalContractSigned: {
                      title: 'Conditional contract signed',
                      type: 'object',
                      properties: {                    
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    },
                                    namesOfContractors: {
                                      type: 'string',
                                      title: 'Name(s) of contracted housebuilders',
                                      extendedText: true
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones contractSigned conditionalContractSigned],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    unconditionalContractSigned: {
                      title: 'Unconditional contract signed',
                      type: 'object',
                      properties: {                        
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones contractSigned unconditionalContractSigned],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    startOnSiteDate: {
                      title: 'Start on site date',
                      type: 'object',
                      properties: {
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      horizontal: true,
                                      type: 'object',
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones workDates startOnSiteDate],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    startOnFirstUnitDate: {
                      title: 'Start of first unit date',
                      type: 'object',
                      properties: {              
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      horizontal: true,
                                      type: 'object',
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones workDates startOnFirstUnitDate],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    completionOfFinalUnitData: {
                      title: 'Completion of Final Unit Date',
                      type: 'object',
                      properties: {
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones completionDates completionOfFinalUnitData],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    projectCompletionDate: {
                      title: 'Project Completion Date',
                      type: 'object',
                      properties: {            
                        completion: {
                          type: 'object',
                          title: '',
                          properties: {
                            completed: {
                              title: 'Completed?',
                              type: 'string',
                              radio: true,
                              enum: %w[Yes No]
                            }
                          },
                          dependencies: {
                            completed: {
                              oneOf: [
                                {
                                  properties: {
                                    completed: {
                                      enum: ['Yes']
                                    },
                                    dateOfCompletion: {
                                      type: 'string',
                                      title: 'Date completed?',
                                      format: 'date'
                                    }
                                  }
                                },
                                {
                                  properties: {
                                    completed: {
                                      enum: ['No']
                                    },
                                    details: {
                                      type: 'object',
                                      horizontal: true,
                                      title: '',
                                      properties: {
                                        baselineDate: {
                                          type: 'string',
                                          format: 'date',
                                          title: 'Baseline Date',
                                          sourceKey: %i[baseline_data milestones completionDates projectCompletionDate],
                                          readonly: true
                                        },
                                        currentEstimatedDate: {
                                          type: 'string',
                                          title: 'Current estimated date',
                                          format: 'date'
                                        },
                                        estimatedPercentageComplete: {
                                          type: 'string',
                                          title: 'Estimated percentage complete',
                                          percentage: true
                                        }
                                      }
                                    },
                                    risk: {
                                      title: '',
                                      type: 'object',
                                      horizontal: true,
                                      properties: {
                                        riskToAchievingBaseline: {
                                          type: 'string',
                                          title: 'Risk to achieving baseline date',
                                          radio: true,
                                          enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                        },
                                        reasonForVariance: {
                                          type: 'string',
                                          title: 'Reasn for risk/ variance',
                                          extendedText: true
                                        }
                                      }
                                    }
                                  }
                                }
                              ]
                            }
                          }
                        }
                      }
                    },
                    customMileStones: {
                      type: 'array',
                      addable: true,
                      title: 'Custom Milestones',
                      items: {
                        type: 'object',
                        properties: {
                          milestoneName: {
                            type: 'string',
                            title: 'Name of custom milestone',
                            sourceKey: %i[baseline_data milestones customMileStones customName]
                          },
                          completion: {
                            type: 'object',
                            title: '',
                            properties: {
                              completed: {
                                title: 'Completed?',
                                type: 'string',
                                radio: true,
                                enum: %w[Yes No]
                              }
                            },
                            dependencies: {
                              completed: {
                                oneOf: [
                                  {
                                    properties: {
                                      completed: {
                                        enum: ['Yes']
                                      },
                                      dateOfCompletion: {
                                        type: 'string',
                                        title: 'Date completed?',
                                        format: 'date'
                                      }
                                    }
                                  },
                                  {
                                    properties: {
                                      completed: {
                                        enum: ['No']
                                      },
                                      details: {
                                        type: 'object',
                                        horizontal: true,
                                        title: '',
                                        properties: {
                                          baselineDate: {
                                            type: 'string',
                                            format: 'date',
                                            title: 'Baseline Date',
                                            sourceKey: %i[baseline_data milestones customMileStones customDate],
                                            readonly: true
                                          },
                                          currentEstimatedDate: {
                                            type: 'string',
                                            title: 'Current estimated date',
                                            format: 'date'
                                          },
                                          estimatedPercentageComplete: {
                                            type: 'string',
                                            title: 'Estimated percentage complete',
                                            percentage: true
                                          }
                                        }
                                      },
                                      risk: {
                                        title: '',
                                        type: 'object',
                                        horizontal: true,
                                        properties: {
                                          riskToAchievingBaseline: {
                                            type: 'string',
                                            title: 'Risk to achieving baseline date',
                                            radio: true,
                                            enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
                                          },
                                          reasonForVariance: {
                                            type: 'string',
                                            title: 'Reasn for risk/ variance',
                                            extendedText: true
                                          }
                                        }
                                      }
                                    }
                                  }
                                ]
                              }
                            }
                          }
                        }
                      }
                    },
                    planningStatus: {
                      type: 'string',
                      title: 'Planning Status',
                      enum: [
                        'Not in allocated for housing in Local Plan',
                        'Provisional allocation for housing',
                        'Allocated for housing in Local Plan',
                        'Outline or Reserved Matters',
                        'Consent granted'
                      ]
                    },
                    changeRequired: {
                      type: 'string',
                      title: 'Change Required?',
                      radio: true,
                      enum: ['Do not change baseline', 'Request change to baseline to match latest estimates']
                    }
                  },
                  dependencies: {
                    changeRequired: {
                      oneOf: [
                        {
                          properties: {
                            changeRequired: {
                              enum: ['Request change to baseline to match latest estimates']
                            },
                            reason: {
                              type: 'string',
                              extendedText: true,
                              title: 'Reason for change/variance, and steps being taken to address this'
                            }
                          }
                        },
                        {
                          properties: {
                            changeRequired: {
                              enum: ['Do not change baseline']
                            }
                          }
                        }
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      }
    end

    add_grant_expenditure_tab
    add_s151_grant_approval
    add_housing_outputs
    add_s151_submission
    add_review_and_assurance_tab 

    @return_template
  end

  private

  def add_grant_expenditure_tab
    @return_template.schema[:properties][:grantExpenditure] = {
      title: 'Grant Expenditure Profile',
      type: 'object',
      properties: {
        baseline: {
          type: 'array',
          title: 'Baseline',
          quarterly: true,
          items: {
            type: 'object',
            title: '',
            properties: {
              year: {
                type: "string",
                title: "Year",
                readonly: true,
                sourceKey: %i[baseline_data financials expenditure year]
              },
              Q1Amount: {
                type: "string",
                title: "First Quarter",
                currency: true,
                readonly: true,
                sourceKey: %i[baseline_data financials expenditure Q1Amount]
              },
              Q2Amount: {
                type: "string",
                title: "Second Quarter",
                currency: true,
                readonly: true,
                sourceKey: %i[baseline_data financials expenditure Q2Amount]
              },
              Q3Amount: {
                type: "string",
                title: "Third Quarter",
                currency: true,
                readonly: true,
                sourceKey: %i[baseline_data financials expenditure Q3Amount]
              },
              Q4Amount: {
                type: "string",
                title: "Fourth Quarter",
                currency: true,
                readonly: true,
                sourceKey: %i[baseline_data financials expenditure Q4Amount]
              },
              total: {
                type: 'string',
                title: 'Total',
                currency: true,
                readonly: true
              }
            }
          }
        },
        claimedToDate: {
          type: 'array',
          title: 'Claimed to date',
          quarterly: true,
          items: {
            type: 'object',
            title: '',
            properties: {
              year: {
                type: "string",
                title: "Year",
                sourceKey: %i[baseline_data financials expenditure year]
              },
              Q1Amount: {
                type: "string",
                title: "First Quarter",
                currency: true
              },
              Q2Amount: {
                type: "string",
                title: "Second Quarter",
                currency: true
              },
              Q3Amount: {
                type: "string",
                title: "Third Quarter",
                currency: true
              },
              Q4Amount: {
                type: "string",
                title: "Fourth Quarter",
                currency: true
              },
              total: {
                type: 'string',
                title: 'Total',
                currency: true,
                readonly: true
              }
            }
          }
        },
        remainingEstimate: {
          type: 'array',
          title: 'Remaining Estimate',
          quarterly: true,
          items: {
            type: 'object',
            title: '',
            properties: {
              year: {
                type: "string",
                title: "Year",
                sourceKey: %i[baseline_data financials expenditure year]
              },
              Q1Amount: {
                type: "string",
                title: "First Quarter",
                currency: true
              },
              Q2Amount: {
                type: "string",
                title: "Second Quarter",
                currency: true
              },
              Q3Amount: {
                type: "string",
                title: "Third Quarter",
                currency: true
              },
              Q4Amount: {
                type: "string",
                title: "Fourth Quarter",
                currency: true
              },
              total: {
                type: 'string',
                title: 'Total',
                currency: true,
                readonly: true
              }
            }
          }
        },
        riskRating: {
          type: 'array',
          title: 'Risk Rating',
          quarterly: true,
          items: {
            type: 'object',
            title: '',
            properties: {
              year: {
                type: "string",
                title: "Year",
                sourceKey: %i[baseline_data financials expenditure year]
              },
              Q1Rating: {
                type: "string",
                title: "First Quarter",
                enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
              },
              Q2Rating: {
                type: "string",
                title: "Second Quarter",
                enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
              },
              Q3Rating: {
                type: "string",
                title: "Third Quarter",
                enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
              },
              Q4Rating: {
                type: "string",
                title: "Fourth Quarter",
                enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High']
              },
              total: {
                type: 'string',
                title: 'Total',
                enum: ['Already Achieved', 'Low', 'Medium Low', 'Medium High', 'High'],
                readonly: true
              }
            }
          }
        },
        changesRequired: {
          type: 'string',
          radio: true,
          title: 'Changes Required?',
          enum: ['Do not change the baseline', 'Request change to baseline to match latest estimates']
        }
      },
      dependencies: {
        changesRequired: {
          oneOf: [
            {
              properties: {
                changesRequired: {
                  enum: ['Do not change the baseline']
                }
              }
            },
            {
              properties: {
                changesRequired: {
                  enum: ['Request change to baseline to match latest estimates']
                },
                reasonForChange: {
                  type: 'string',
                  title: 'Reason for change/variance, and steps being taken to address this',
                  extendedText: true
                }
              }
            }
          ]
        }
      }
    }
  end

  def add_s151_grant_approval
    @return_template.schema[:properties][:s151GrantClaimApproval] = {
      title: 'S151 Officer Grant Claim Approval',
      type: 'object',
      properties: {
        claimSummary: {
          title: 'Summary of Claim',
          type: 'object',
          properties: {
            TotalFundingRequest: {
              type: 'string',
              title: 'Total Funding Request',
              currency: true
            },
            SpendToDate: {
              type: 'string',
              hidden: true,
              title: 'Spend to Date',
              currency: true
            },
            AmountOfThisClaim: {
              type: 'string',
              title: 'Amount of this Claim',
              currency: true
            }
          }
        },
        supportingEvidence: {
          type: 'object',
          title: 'Supporting Evidence',
          properties: {
            lastQuarterMonthSpend: {
              type: 'object',
              title: 'Last Quarter Month Spend',
              properties: {
                forecast: {
                  title: 'Forecasted Spend Last Quarter Month',
                  type: 'string',
                  hidden: true,
                  currency: true
                },
                actual: {
                  title: 'Actual Spend Last Quarter Month',
                  type: 'string',
                  currency: true
                },
                varianceAgainstForcastAmount: {
                  title: 'Variance Against Forecast',
                  type: 'string',
                  hidden: true,
                  currency: true
                },
                varianceAgainstForcastPercentage: {
                  title: 'Variance Against Forecast',
                  type: 'string',
                  percentage: true,
                  hidden: true
                }
              }
            },
            evidenceOfSpendPastQuarter: {
              title: 'Evidence of Spend for the Past Quarter.',
              type: 'string',
              hidden: true
            },
            breakdownOfNextQuarterSpend: {
              title: 'Evidence of Next Quarter Spend',
              type: 'object',
              properties: {
                forecast: {
                  title: 'Forecasted Spend (£)',
                  type: 'string',
                  currency: true
                },
                descriptionOfSpend: {
                  title: 'Description of Spend',
                  type: 'string',
                  extendedText: true
                },
                evidenceOfSpendNextQuarter: {
                  title: 'Evidence of Spend for the Past Quarter.',
                  type: 'string',
                  hidden: true
                }
              }
            }
          }
        }
      }
    }
  end

  def add_housing_outputs
    @return_template.schema[:properties][:housingOutputs] = {
      title: 'Housing Outputs',
      type: 'object',
      properties: {
        tbc: {
          type: 'object',
          title: '',
          properties: {
            tbc: {
              type: 'string',
              title: 'Still awaiting Details from anthony',
              readonly: true
            }
          }
        }
      }
    }
  end

  def add_s151_submission
    @return_template.schema[:properties][:s151submission] = {
      title: 'S151 Officer Submission Sign-Off',
      type: 'object',
      properties: {
        submission: {
          type: 'object',
          title: '',
          properties: {
            confirmation: {
              type: 'object',
              title: 'Please confirm you are content with the submission, including:',
              properties: {
                estimatedGrantProfiles: {
                  type: 'string',
                  title: 'Estimated grant draw down profiles, including any changes requested to these',
                  enum: %w[Yes No],
                  radio: true
                },
                milestoneDateEstimates: {
                  type: 'string',
                  title: 'Milestone date estimates, including any changes requested to these',
                  enum: %w[Yes No],
                  radio: true
                },
                milestoneDatesAchieved: {
                  type: 'string',
                  title: 'Milestone dates achieved, including any evidence submitted to validate these',
                  enum: %w[Yes No],
                  radio: true
                },
                housingOutputsEstimates: {
                  type: 'string',
                  title: 'Housing output profile estimates, including any changes requested to these',
                  enum: %w[Yes No],
                  radio: true
                },
                housingClaimedAsAchieved: {
                  type: 'string',
                  title: 'Housing outputs claimed as achieved, including any evidence submitted to validate these',
                  enum: %w[Yes No],
                  radio: true
                },
                receiptEstimates: {
                  type: 'string',
                  title: 'Receipt (income) estimates and actual income, including any evidence submitted to validate these',
                  enum: %w[Yes No],
                  radio: true
                },
                noOtherGrantFundin: {
                  type: 'string',
                  title: 'That no other Grant Funding Agreement conditions have been breached.',
                  enum: %w[Yes No],
                  radio: true
                }
              }
            }
          }
        }
      }
    }
  end

  def add_review_and_assurance_tab 
    @return_template.schema[:properties][:reviewAndAssurance] = {
      title: 'Review and Assurance',
      type: 'object',
      properties: {
        date: {
          title: 'Date of most recent meeting',
          type: 'string',
          format: 'date'
        },
        infrastructureDelivery: {
          type: 'object',
          title: '',
          horizontal: true,
          properties: {
            details: {
              type: 'string',
              title: 'Infrastructure Delivery',
              extendedText: true
            },
            riskRating: {
              type: 'string',
              title: 'Risk Rating',
              radio: true,
              enum: ['High', 'Medium High', 'Medium Low', 'Low', 'Contractual']
            }
          }
        },
        planningAndProcurement: {
          type: 'object',
          title: '',
          horizontal: true,
          properties: {
            details: {
              type: 'string',
              title: 'Planning and Procurement',
              extendedText: true
            },
            riskRating: {
              type: 'string',
              title: 'Risk Rating',
              radio: true,
              enum: ['High', 'Medium High', 'Medium Low', 'Low', 'Contractual']
            }
          }
        },
        expenditure: {
          type: 'object',
          title: '',
          horizontal: true,
          properties: {
            details: {
              type: 'string',
              title: 'Expenditure',
              extendedText: true
            },
            riskRating: {
              type: 'string',
              title: 'Risk Rating',
              radio: true,
              enum: ['High', 'Medium High', 'Medium Low', 'Low', 'Contractual']
            }
          }
        },
        deliverablesObjectivesAndOutputs: {
          type: 'object',
          title: '',
          horizontal: true,
          properties: {
            details: {
              type: 'string',
              title: 'Deliverables, Objectives and Outputs',
              extendedText: true
            },
            riskRating: {
              type: 'string',
              title: 'Risk Rating',
              radio: true,
              enum: ['High', 'Medium High', 'Medium Low', 'Low', 'Contractual']
            }
          }
        },
        overallSummary: {
          type: 'object',
          title: '',
          horizontal: true,
          properties: {
            details: {
              type: 'string',
              title: 'Overall Summary',
              extendedText: true
            },
            riskRating: {
              type: 'string',
              title: 'Risk Rating',
              radio: true,
              enum: ['High', 'Medium High', 'Medium Low', 'Low', 'Contractual']
            }
          }
        },
        overallRagRating: {
          type: 'string',
          title: 'Overall Rag Rating',
          radio: true,
          enum: ['High', 'Medium High', 'Medium Low', 'Low', 'Contractual']
        }
      }
    }
  end
end
