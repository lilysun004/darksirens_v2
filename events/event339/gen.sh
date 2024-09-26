lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.152552552552553 --fixed-mass2 65.14898898898899 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016590495.5146698 \
--gps-end-time 1016597695.5146698 \
--d-distr volume \
--min-distance 2184.514360749029e3 --max-distance 2184.5343607490295e3 \
--l-distr fixed --longitude 114.9524917602539 --latitude -46.55701446533203 --i-distr uniform \
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
