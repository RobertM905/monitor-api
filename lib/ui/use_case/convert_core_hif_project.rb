# frozen_string_literal: true

class UI::UseCase::ConvertCoreHIFProject
  def execute(project_data:)
    @project = project_data
    @converted_project = {}

    convert_project_summary
    convert_infrastructures
    convert_funding_profiles
    convert_costs
    convert_baseline_cash_flow
    convert_recovery
    convert_s151
    convert_outputs_forecast
    convert_outputs_actuals

    @converted_project
  end

  private

  def convert_project_summary
    return if @project[:summary].nil?

    @converted_project[:summary] = {
      BIDReference: @project[:summary][:BIDReference],
      projectName: @project[:summary][:projectName],
      leadAuthority: @project[:summary][:leadAuthority],
      jointBidAreas: @project[:summary][:jointBidAreas],
      projectDescription: @project[:summary][:projectDescription],
      greenOrBrownField: @project[:summary][:greenOrBrownField],
      noOfHousingSites: @project[:summary][:noOfHousingSites],
      totalArea: @project[:summary][:totalArea],
      hifFundingAmount: @project[:summary][:hifFundingAmount],
      descriptionOfInfrastructure: @project[:summary][:descriptionOfInfrastructure],
      descriptionOfWiderProjectDeliverables: @project[:summary][:descriptionOfWiderProjectDeliverables]
    }

    @converted_project[:summary].compact!
  end

  def convert_infrastructures
    @converted_project[:infrastructures] = @project[:infrastructures].map do |infrastructure|
      converted_infrastructure = {}
      converted_infrastructure[:type] = infrastructure[:type]
      converted_infrastructure[:description] = infrastructure[:description]
      converted_infrastructure[:housingSitesBenefitting] = infrastructure[:housingSitesBenefitting]

      unless infrastructure[:outlinePlanningStatus].nil?
        converted_infrastructure[:outlinePlanningStatus] = {
          granted: infrastructure[:outlinePlanningStatus][:granted],
          reference: infrastructure[:outlinePlanningStatus][:reference],
          targetSubmission: infrastructure[:outlinePlanningStatus][:targetSubmission],
          targetGranted: infrastructure[:outlinePlanningStatus][:targetGranted],
          summaryOfCriticalPath: infrastructure[:outlinePlanningStatus][:summaryOfCriticalPath]
        }
      end

      unless infrastructure[:fullPlanningStatus].nil?
        converted_infrastructure[:fullPlanningStatus] = {
          granted: infrastructure[:fullPlanningStatus][:granted],
          grantedReference: infrastructure[:fullPlanningStatus][:grantedReference],
          targetSubmission: infrastructure[:fullPlanningStatus][:targetSubmission],
          targetGranted: infrastructure[:fullPlanningStatus][:targetGranted],
          summaryOfCriticalPath: infrastructure[:fullPlanningStatus][:summaryOfCriticalPath]
        }
      end

      unless infrastructure[:s106].nil?
        converted_infrastructure[:s106] = {
          requirement: infrastructure[:s106][:requirement],
          summaryOfRequirement: infrastructure[:s106][:summaryOfRequirement]
        }
      end

      unless infrastructure[:statutoryConsents].nil?
        converted_infrastructure[:statutoryConsents] = {
          anyConsents: infrastructure[:statutoryConsents][:anyConsents],
          consents: infrastructure[:statutoryConsents][:consents].map do |consent|
            {
              detailsOfConsent: consent[:detailsOfConsent],
              targetDateToBeMet: consent[:targetDateToBeMet]
            }
          end
        }
      end

      unless infrastructure[:landOwnership].nil?
        converted_infrastructure[:landOwnership] = {
          underControlOfLA: infrastructure[:landOwnership][:underControlOfLA],
          ownershipOfLandOtherThanLA: infrastructure[:landOwnership][:ownershipOfLandOtherThanLA],
          landAcquisitionRequired: infrastructure[:landOwnership][:landAcquisitionRequired],
          howManySitesToAcquire: infrastructure[:landOwnership][:howManySitesToAcquire],
          toBeAcquiredBy: infrastructure[:landOwnership][:toBeAcquiredBy],
          targetDateToAcquire: infrastructure[:landOwnership][:targetDateToAcquire],
          summaryOfCriticalPath: infrastructure[:landOwnership][:summaryOfCriticalPath]
        }
      end

      unless infrastructure[:procurement].nil?
        converted_infrastructure[:procurement] = {
          contractorProcured: infrastructure[:procurement][:contractorProcured],
          nameOfContractor: infrastructure[:procurement][:nameOfContractor],
          targetDate: infrastructure[:procurement][:targetDate],
          summaryOfCriticalPath: infrastructure[:procurement][:summaryOfCriticalPath]
        }
      end

      unless infrastructure[:milestones].nil?
        converted_infrastructure[:milestones] = infrastructure[:milestones].map do |milestone|
          {
            descriptionOfMilestone: milestone[:descriptionOfMilestone],
            target: milestone[:target],
            summaryOfCriticalPath: milestone[:summaryOfCriticalPath]
          }
        end
      end

      unless infrastructure[:expectedInfrastructureStart].nil?
        converted_infrastructure[:expectedInfrastructureStart] = {
          targetDateOfAchievingStart: infrastructure[:expectedInfrastructureStart][:targetDateOfAchievingStart]
        }
      end

      unless infrastructure[:expectedInfrastructureCompletion].nil?
        converted_infrastructure[:expectedInfrastructureCompletion] = {
          targetDateOfAchievingCompletion: infrastructure[:expectedInfrastructureCompletion][:targetDateOfAchievingCompletion]
        }
      end

      unless infrastructure[:risksToAchievingTimescales].nil?
        converted_infrastructure[:risksToAchievingTimescales] = infrastructure[:risksToAchievingTimescales].map do |risk|
          {
            descriptionOfRisk: risk[:descriptionOfRisk],
            impactOfRisk: risk[:impactOfRisk],
            likelihoodOfRisk: risk[:likelihoodOfRisk],
            mitigationOfRisk: risk[:mitigationOfRisk]
          }
        end
      end

      converted_infrastructure.compact
    end
  end

  def convert_funding_profiles
    @converted_project[:fundingProfiles] = @project[:fundingProfiles].map do |profile|
      {
        period: profile[:period],
        instalment1: profile[:instalment1],
        instalment2: profile[:instalment2],
        instalment3: profile[:instalment3],
        instalment4: profile[:instalment4],
        total: profile[:total]
      }
    end

    @converted_project[:fundingProfiles].each(&:compact!)
  end

  def convert_costs
    return if @project[:costs].nil?
    @converted_project[:costs] = []

    @converted_project[:costs] = @project[:costs].each do |cost|
      converted_cost = {}

      unless cost[:infrastructures].nil?
        converted_cost[:infrastructure] = {
          HIFAmount: cost[:infrastructure][:HIFAmount],
          totalCostOfInfrastructure: cost[:infrastructure][:totalCostOfInfrastructure],
          totallyFundedThroughHIF: cost[:infrastructure][:totallyFundedThroughHIF],
          descriptionOfFundingStack: cost[:infrastructure][:descriptionOfFundingStack],
          totalPublic: cost[:infrastructure][:totalPublic],
          totalPrivate: cost[:infrastructure][:totalPrivate]
        }
      end

      @converted_project[:costs] << converted_cost
    end
  end

  def convert_baseline_cash_flow
    return if @project[:baselineCashFlow].nil?

    @converted_project[:baselineCashFlow] = {
      summaryOfRequirement: @project[:baselineCashFlow][:summaryOfRequirement]
    }
  end

  def convert_recovery
    return if @project[:recovery].nil?

    @converted_project[:recovery] = {
      aimToRecover: @project[:recovery][:aimToRecover],
      expectedAmountToRecover: @project[:recovery][:expectedAmountToRecover],
      methodOfRecovery: @project[:recovery][:methodOfRecovery]
    }

    @converted_project[:recovery].compact!
  end

  def convert_s151
    return if @project[:s151].nil?

    @converted_project[:s151] = {
      s151FundingEndDate: @project[:s151][:s151FundingEndDate],
      s151ProjectLongstopDate: @project[:s151][:s151ProjectLongstopDate]
    }
  end

  def convert_outputs_forecast
    return if @project[:outputsForecast].nil?

    @converted_project[:outputsForecast] = {
      totalUnits: @project[:outputsForecast][:totalUnits],
      disposalStrategy: @project[:outputsForecast][:disposalStrategy]
    }

    @converted_project[:outputsForecast].compact!

    return if @project[:outputsForecast][:housingForecast].nil?

    @converted_project[:outputsForecast][:housingForecast] = @project[:outputsForecast][:housingForecast].map do |forecast|
      {
        period: forecast[:period],
        target: forecast[:target],
        housingCompletions: forecast[:housingCompletions]
      }
    end
  end

  def convert_outputs_actuals
    return if @project[:outputsActuals].nil?

    @converted_project[:outputsActuals] = {}

    return if @project[:outputsActuals][:siteOutputs].nil?

    @converted_project[:outputsActuals] = {
      siteOutputs: @project[:outputsActuals][:siteOutputs].map do |output|
        {
          siteName: output[:siteName],
          siteLocalAuthority: output[:siteLocalAuthority],
          siteNumberOfUnits: output[:siteNumberOfUnits]
        }
      end
    }
  end
end