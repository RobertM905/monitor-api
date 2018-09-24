class HomesEngland::Builder::Template::Templates::HIFTemplate
  def create
    hif_template = HomesEngland::Domain::Template.new
    hif_template.schema = {
      '$schema': 'http://json-schema.org/draft-07/schema',
      title: 'HIF Project',
      type: 'object',
      properties: {
        summary: hif_summary,
        infrastructures: hif_infrastructures,
        financial: hif_finances,
        s151: hif_s151,
        outputsForecast: outputs_forecast,
        outputsActuals: outputs_actuals
      }
    }
    hif_template
  end

  private

  def hif_finances
    {
      type: 'array',
      title: 'Financials',
      items: {
        type: 'object',
        properties: {
          period: { type: 'string', title: 'Period' },
          instalments: {
            type: 'array',
            title: 'Instalments',
            items: {
              type: 'object',
              properties: {
                dateOfInstalment: {
                  type: 'string',
                  format: 'date',
                  title: 'Date of Instalment'
                },
                instalmentAmount: {
                  type: 'string',
                  title: 'HIF Funding Profile - Baseline'
                },
                baselineInstalments: {
                  type: 'array',
                  title: 'Baseline Instalments',
                  items: {
                    type: 'object',
                    properties: {
                      baselineInstalmentYear: {
                        type: 'string',
                        title: 'Baseline Instalment Year'
                      },
                      baselineInstalmentQ1: {
                        type: 'string',
                        title: 'Baseline Instalment Q1'
                      },
                      baselineInstalmentQ2: {
                        type: 'string',
                        title: 'Baseline Instalment Q2'
                      },
                      baselineInstalmentQ3: {
                        type: 'string',
                        title: 'Baseline Instalment Q3'
                      },
                      baselineInstalmentQ4: {
                        type: 'string',
                        title: 'Baseline Instalment Q4'
                      },
                      baselineInstalmentTotal: {
                        type: 'string',
                        title: 'Baseline Instalment Total'
                      }
                    }
                  }
                }
              }
            }
          },
          costs: {
            type: 'array',
            title: 'Cost of Infrastructures',
            items: {
              type: 'object',
              properties: {
                costOfInfrastructure: {
                  type: 'string',
                  title: 'Cost of Infrastructure'
                },
                fundingStack: {
                  type: 'object',
                  title: 'Totally funded through HIF',
                  properties: {
                    totallyFundedThroughHIF: {
                      type: 'string',
                      title: 'Totally funded through HIF?',
                      items: {
                        type: 'string',
                        enum: %w[Yes No]
                      }
                    },
                    descriptionOfFundingStack: {
                      type: 'string',
                      title: 'If No: Description of Funding Stack'
                    },
                    totalPublic: {
                      type: 'string',
                      title: 'If No, Total Public (exc. HIF)'
                    },
                    totalPrivate: {
                      type: 'string',
                      title: 'If No, Total Private'
                    }
                  }
                }
              }
            }
          },
          baselineCashflow: {
            type: 'object',
            title: 'Baseline Cashflow',
            properties: {
              summaryOfRequirement: {
                type: 'string',
                format: 'data-url',
                title: 'Baseline Cashflow'
              }
            }
          },

          recovery: {
            type: 'object',
            title: 'Recovery',
            properties: {
              aimToRecover: {
                type: 'string',
                title: 'Aim to Recover?',
                items: {
                  type: 'string',
                  enum: %w[Yes No]
                }
              },
              expectedAmountToRemove: {
                type: 'integer',
                title: 'Expected Amount'
              },
              methodOfRecovery: {
                type: 'string',
                title: 'Method of Recovery?'
              }
            }
          }
        }
      }
    }
  end

  def hif_infrastructures
    {
      type: 'array',
      title: 'Infrastructures',
      items: {
        type: 'object',
        properties: {
          type: {
            type: 'string',
            title: 'Type'
          },
          description: {
            type: 'string',
            title: 'Description'
          },
          outlinePlanningStatus: {
            type: 'object',
            title: 'Outline Planning Status',
            properties: {
              granted: {
                type: 'string',
                title: 'Granted?',
                items: {
                  type: 'string',
                  enum: %w[Yes No]
                }
              },
              grantedReference: {
                type: 'string',
                title: 'If Yes: Reference '
              },
              targetSubmission: {
                type: 'string',
                format: 'date',
                title: 'If No: Target date of submission'
              },
              targetGranted: {
                type: 'string',
                format: 'date',
                title: 'If No: Target date of planning granted'
              },
              summaryOfCriticalPath: {
                type: 'string',
                title: 'If No: Summary of Critical Path'
              }
            }
          },
          fullPlanningStatus: {
            type: 'object',
            title: 'Full Planning Status',
            properties: {
              granted: {
                type: 'string',
                title: 'Granted?',
                items: {
                  type: 'string',
                  enum: %w[Yes No]
                }
              },
              grantedReference: {
                type: 'string',
                title: 'If Yes: Reference '
              },
              targetSubmission: {
                type: 'string',
                format: 'date',
                title: 'If No: Target date of submission'
              },
              targetGranted: {
                type: 'string',
                format: 'date',
                title: 'If No: Target date of planning granted'
              },
              summaryOfCriticalPath: {
                type: 'string',
                title: 'If No: Summary of Critical Path'
              }
            }
          },
          s106: {
            type: 'object',
            title: 'Section 106',
            properties: {
              requirement: {
                type: 'string',
                title: 'A requirement?',
                items: {
                  type: 'string',
                  enum: %w[Yes No]
                }
              },
              summaryOfRequirement: {
                type: 'string',
                title: 'If Yes: Summary of requirement'
              }
            }
          },
          statutoryConsents: {
            type: 'object',
            title: 'Statutory Consents',
            properties: {
              anyConsents: {
                type: 'string',
                title: 'Any Statutory Consents?',
                items: {
                  type: 'string',
                  enum: %w[Yes No]
                }
              },
              detailsOfConsent: {
                type: 'string',
                title: 'If Yes: Details of consent'
              },
              targetDateToBeMet: {
                type: 'string',
                format: 'date',
                title: 'If Yes: Target date to be met'
              }
            }
          },
          landOwnership: {
            type: 'object',
            title: 'Land Ownership',
            properties: {
              underControlOfLA: {
                type: 'string',
                title: 'Is land under control of the Local Authority',
                items: {
                  type: 'string',
                  enum: %w[Yes No]
                }
              },
              ownershipOfLandOtherThanLA: {
                type: 'string',
                title: 'If No: who owns it?'
              },
              landAcquisitionRequired: {
                type: 'string',
                title: 'Is land acquisition required?',
                items: {
                  type: 'string',
                  enum: %w[Yes No]
                }
              },
              howManySitesToAcquire: {
                type: 'integer',
                title: 'If Yes: How many sites to aquire?'
              },
              toBeAcquiredBy: {
                type: 'string',
                title: 'If Yes: Is this to be acquired by LA or developer?'
              },
              targetDateToAcquire: {
                type: 'string',
                format: 'date',
                title: 'If Yes: Target date to aquire sites'
              },
              summaryOfCriticalPath: {
                type: 'string',
                title: 'If Yes: Summary of Critical Path'
              }
            }
          },
          procurement: {
            type: 'object',
            title: 'Procurement',
            properties: {
              contractorProcured: {
                type: 'string',
                title: 'Is the infrastructure contractor procured?',
                items: {
                  type: 'string',
                  enum: %w[Yes No]
                }
              },

              nameOfContractor: {
                type: 'string',
                title: 'If Yes: Name of Contractor?'
              },

              targetDateToAquire: {
                type: 'string',
                format: 'date',
                title: 'If No: Target date of procuring'
              },

              summaryOfCriticalPath: {
                type: 'string',
                title: 'If No: Summary of Critical Path'
              }
            }
          },
          milestones: {
            type: 'array',
            title: 'Key Infrastructure Milestones',
            items: {
              type: 'object',
              properties: {
                descriptionOfMilestone: {
                  type: 'string',
                  title: 'Description of Milestone'
                },
                target: {
                  type: 'string',
                  format: 'date',
                  title: 'Target date of achieving'
                },
                summaryOfCriticalPath: {
                  type: 'string',
                  title: 'Summary of Critical Path'
                }
              }
            }
          },
          expectedInfrastructureStart: {
            type: 'object',
            title: 'Expected infrastructure start on site',
            properties: {
              targetDateOfAchievingStart: {
                type: 'string',
                format: 'date',
                title: 'Target date of achieving start'
              }
            }
          },
          expectedInfrastructureCompletion: {
            type: 'object',
            title: 'Expected infrastructure completion',
            properties: {
              targetDateOfAchievingCompletion: {
                type: 'string',
                format: 'date',
                title: 'Target date of achieving completion'
              }
            }
          },
          risksToAchievingTimescales: {
            type: 'array',
            title: 'Risks to achieving timescales',
            items: {
              type: 'object',
              properties: {
                descriptionOfRisk: {
                  type: 'string',
                  title: 'Description Of Risk'
                },
                impactOfRisk: {
                  type: 'string',
                  title: 'Impact'
                },
                likelihoodOfRisk: {
                  type: 'string',
                  title: 'Likelihood'
                },
                mitigationOfRisk: {
                  type: 'string',
                  title: 'Mitigation in place'
                }
              }
            }
          }
        }
      }
    }
  end

  def hif_summary
    {
      type: 'object',
      title: 'Project Summary',
      properties: {
        BIDReference: {
          type: 'string',
          title: 'BID Reference'
        },
        projectName: {
          type: 'string',
          title: 'Project Name'
        },
        leadAuthority: {
          type: 'string',
          title: 'Lead Authority'
        },
        projectDescription: {
          type: 'string',
          title: 'Project Description'
        },
        noOfHousingSites: {
          type: 'integer',
          title: 'Number of housing sites'
        },
        totalArea: {
          type: 'integer',
          title: 'Total Area (hectares)'
        },
        hifFundingAmount: {
          type: 'integer',
          title: 'HIF Funding Amount (£)'
        },
        descriptionOfInfrastructure: {
          type: 'string',
          title: 'Description of HIF Infrastructure to be delivered'
        },
        descriptionOfWiderProjectDeliverables: {
          type: 'string',
          title: 'Description of wider project deliverables'
        }
      }
    }
  end

  def hif_s151
    {
      type: 'object',
      title: 'Section 151',
      properties: {
        s151FundingEndDate: {
          type: 'string',
          format: 'date',
          title: 'HIF Funding End Date'
        },
        s151ProjectLongstopDate: {
          type: 'string',
          format: 'date',
          title: 'Project Longstop date'
        }
      }
    }
  end

  def outputs_forecast
    {
      type: 'object',
      title: 'Outputs - Forecast',
      properties: {
        totalUnits: {
          type: 'integer',
          title: 'Total Units'
        },
        disposalStrategy: {
          type: 'string',
          title: 'Disposal Strategy / Critical Path'
        },
        housingForecast: {
          type: 'array',
          title: 'Housing Forecast',
          items: {
            type: 'object',
            properties: {
              date: {
                type: 'string',
                format: 'date',
                title: 'Date'
              },
              target: {
                type: 'string',
                format: 'date',
                title: 'Housing Starts'
              },
              housingCompletions: {
                type: 'string',
                format: 'date',
                title: 'Housing Completions'
              }
            }
          }
        }
      }
    }
  end

  def outputs_actuals
    {
      type: 'object',
      title: 'Outputs - Actual',
      properties: {
        siteOutputs: {
          type: 'array',
          title: 'Site Outputs',
          items: {
            type: 'object',
            properties: {
              siteName: {
                type: 'string',
                title: 'Name of site'
              },
              siteLocalAuthority: {
                type: 'string',
                title: 'Local Authority'
              },
              siteNumberOfUnits: {
                type: 'string',
                title: 'Number of Units'
              }
            }
          }
        }
      }
    }
  end
end
