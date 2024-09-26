lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 63.720240240240244 --fixed-mass2 51.533853853853856 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022714688.5363979 \
--gps-end-time 1022721888.5363979 \
--d-distr volume \
--min-distance 2161.5070587967716e3 --max-distance 2161.527058796772e3 \
--l-distr fixed --longitude 47.36418914794922 --latitude 87.4865951538086 --i-distr uniform \
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
