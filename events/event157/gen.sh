lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.4022022022022025 --fixed-mass2 78.93221221221222 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030526171.2382009 \
--gps-end-time 1030533371.2382009 \
--d-distr volume \
--min-distance 494.87453946124117e3 --max-distance 494.89453946124115e3 \
--l-distr fixed --longitude -147.4152374267578 --latitude 21.96258544921875 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
