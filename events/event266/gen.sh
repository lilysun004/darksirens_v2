lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.999039039039039 --fixed-mass2 60.94678678678679 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027805545.787087 \
--gps-end-time 1027812745.787087 \
--d-distr volume \
--min-distance 1794.3374570359126e3 --max-distance 1794.3574570359126e3 \
--l-distr fixed --longitude 166.09402465820312 --latitude 37.633460998535156 --i-distr uniform \
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
