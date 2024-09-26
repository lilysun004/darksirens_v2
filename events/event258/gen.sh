lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.26094094094094 --fixed-mass2 46.82738738738739 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023506976.9637301 \
--gps-end-time 1023514176.9637301 \
--d-distr volume \
--min-distance 1846.989244346775e3 --max-distance 1847.009244346775e3 \
--l-distr fixed --longitude 9.262176513671875 --latitude 5.9799723625183105 --i-distr uniform \
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
