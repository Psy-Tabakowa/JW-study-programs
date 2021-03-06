﻿using System;
using System.Collections.Generic;
using System.Text;

namespace SO_5_DistributedAlgorithmSimulator
{
	class SimulationStats
	{
		// singleton
		private static SimulationStats instance = null;
		private SimulationStats() // private constructor
		{
			processorLoadAverage = new Average();
			processorLoadVariationAverage = new Average();
			processorLoadsList = new List<float>();
			processorQuerriesCounter = 0;
		}
		public static SimulationStats getInstance()
		{
			if (instance == null)
				instance = new SimulationStats();
			return instance;
		}


		// other components
		private Average processorLoadAverage;
		private Average processorLoadVariationAverage;
		List<float> processorLoadsList;
		private int processorQuerriesCounter;

		

		public void addNewProcesssorLoad(float processorLoad)
		{
			// average load
			processorLoadAverage.addNewValue(processorLoad);

			// average load variation
			processorLoadsList.Add(processorLoad);
		}


		public void incrementProcessorQueriesCounter()
		{
			processorQuerriesCounter++;
		}


		public float getAveragePorcessorLoading()
		{
			return (float)processorLoadAverage.getAverage();
		}


		public float getAverageLoadVariation()
		{
			// calculate average variation
			float averageLoad = getAveragePorcessorLoading();
			processorLoadVariationAverage.reset();
			foreach (float value in processorLoadsList)
			{
				float curVariation = Math.Abs(value - averageLoad);
				processorLoadVariationAverage.addNewValue(curVariation);
			}

			return (float)processorLoadVariationAverage.getAverage();
		}


		public int getAmtOfProcessorQueries()
		{
			return processorQuerriesCounter;
		}


		public void reset()
		{
			processorLoadAverage.reset();
			processorLoadVariationAverage.reset();
			processorLoadsList.Clear();
			processorQuerriesCounter = 0;
		}
	}
}
