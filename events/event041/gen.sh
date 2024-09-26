lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.714034034034036 --fixed-mass2 61.03083083083084 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027273959.2420226 \
--gps-end-time 1027281159.2420226 \
--d-distr volume \
--min-distance 984.4327846350457e3 --max-distance 984.4527846350456e3 \
--l-distr fixed --longitude 177.94577026367188 --latitude -58.24728012084961 --i-distr uniform \
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
